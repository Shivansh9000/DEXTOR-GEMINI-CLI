#!/usr/bin/env bash
set -euo pipefail

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

MODE="guided"
DRY_RUN=0
PROFILE="auto"
INSTALL_ROOT="${INSTALL_ROOT:-$HOME/.local/share/dextor-gemini-cli}"
LOG_FILE="$INSTALL_ROOT/install.log"
REPORT_FILE="$INSTALL_ROOT/report.txt"
DISTRO=""
CODENAME=""
ID_LIKE=""
ARCH=""
KERNEL=""
HOSTNAME_FQDN=""
GPU_VENDOR="none"
GPU_MODEL=""
GPU_DRIVER_RECOMMENDATION=""
OS_FAMILY="unknown"
NPM_USER_PREFIX="$HOME/.local/npm-global"

mkdir -p "$INSTALL_ROOT"
exec > >(tee -a "$LOG_FILE") 2>&1

usage(){
cat <<'USAGE'
Usage: ./dextor-gemini-cli.sh [options]
  --profile auto|laptop|workstation|hpc|vm|server
  --mode guided|detect|full-auto
  --dry-run
  --help
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --mode=*) MODE="${arg#*=}" ;;
    --profile=*) PROFILE="${arg#*=}" ;;
    --help|-h) usage; exit 0 ;;
    *) warn "Unknown argument: $arg" ;;
  esac
done

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  DISTRO="${ID:-}"
  CODENAME="${VERSION_CODENAME:-}"
  ID_LIKE="${ID_LIKE:-}"
fi
ARCH="$(uname -m)"
KERNEL="$(uname -r)"
HOSTNAME_FQDN="$(hostname -f 2>/dev/null || hostname)"

os_label(){
  case "$DISTRO" in
    ubuntu|pop) OS_FAMILY="ubuntu" ;;
    debian) OS_FAMILY="debian" ;;
    *)
      if [[ "$ID_LIKE" == *ubuntu* ]]; then OS_FAMILY="ubuntu";
      elif [[ "$ID_LIKE" == *debian* ]]; then OS_FAMILY="debian";
      else OS_FAMILY="unknown"; fi
      ;;
  esac
}
os_label

is_virtualized(){ systemd-detect-virt -q >/dev/null 2>&1; }
mem_gb(){ awk '/MemTotal/{printf "%.1f", $2/1024/1024}' /proc/meminfo; }
ram_gb="$(mem_gb 2>/dev/null || echo 0)"

pkg_update(){ run sudo apt-get update -y || warn "apt-get update failed, continuing..."; }
pkg_install(){ run sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"; }

apt_common(){
  pkg_update
  pkg_install ca-certificates curl wget gnupg lsb-release apt-transport-https software-properties-common file unzip zip tar xz-utils jq yq git build-essential pkg-config make cmake ninja-build gcc g++ python3 python3-pip python3-venv python3-dev pipx direnv shellcheck xclip xsel htop tmux tree ripgrep fd-find fzf silversearcher-ag
}

install_docker_engine(){
  info "[Docker] Engine + Compose + Buildx"
  sudo rm -f /etc/apt/keyrings/docker.gpg /etc/apt/sources.list.d/docker.list
  run sudo install -m 0755 -d /etc/apt/keyrings
  if [[ "$OS_FAMILY" == "ubuntu" ]]; then
    run_shell "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
    run_shell "echo \"deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}}) stable\" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null"
  elif [[ "$OS_FAMILY" == "debian" ]]; then
    run_shell "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
    run_shell "echo \"deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo ${VERSION_CODENAME}) stable\" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null"
  else
    warn "Docker install skipped: unsupported distro family"
    return 0
  fi
  run sudo chmod a+r /etc/apt/keyrings/docker.gpg
  pkg_update
  pkg_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  run sudo usermod -aG docker "${USER:-$(id -un)}" || true
}

install_node_stack(){
  info "[Node] NVM + Node LTS + pnpm + bun"
  if ! has nvm; then run_shell 'curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'; fi
  export NVM_DIR="$HOME/.nvm"
  
  # Remove npm prefix if it exists to avoid NVM conflict
  if [[ -f "$HOME/.npmrc" ]]; then
    sed -i '/prefix=/d' "$HOME/.npmrc"
  fi

  set +u # nvm.sh has unbound variables
  [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" || true
  if has nvm; then
    nvm use --delete-prefix --silent || true
    run nvm install --lts
    run nvm use --lts
  else
    warn "nvm not available in current shell; using system node if present"
  fi
  set -u
  mkdir -p "$NPM_USER_PREFIX/bin"
  run npm config set prefix "$NPM_USER_PREFIX" || true
  export PATH="$NPM_USER_PREFIX/bin:$PATH"
  run npm install -g pnpm bun || true
}

install_python_stack(){
  info "[Python] uv + poetry + pipx"
  if ! has pipx; then pkg_install pipx; fi
  run pipx ensurepath || true
  if ! has uv; then run_shell 'curl -LsSf https://astral.sh/uv/install.sh | sh'; fi
  if has pipx; then run pipx install poetry || true; fi
}

install_editors(){
  info "[Editors] VS Code"
  sudo rm -f /etc/apt/sources.list.d/vscode.list /usr/share/keyrings/ms-vscode.gpg /usr/share/keyrings/microsoft.gpg
  run_shell "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/ms-vscode.gpg >/dev/null"
  run_shell "echo \"deb [arch=${ARCH} signed-by=/usr/share/keyrings/ms-vscode.gpg] https://packages.microsoft.com/repos/code stable main\" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null"
  pkg_update
  pkg_install code
}

install_github_cli(){
  info "[GitHub CLI] gh"
  pkg_install gh || true
}

install_gitlab_cli(){
  info "[GitLab CLI] glab"
  if ! has glab; then
    sudo snap install glab || true
  fi
}

install_1password_cli(){
  info "[1Password CLI] op"
  if ! has op; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list
    sudo apt-get update && sudo apt-get install -y 1password-cli
  fi
}

install_box_cli(){
  info "[Box CLI] box"
  if ! has box; then
    # Box CLI is available via npm
    npm install -g @box/cli || true
  fi
}

bootstrap_sub_agents(){
  info "[Agents] Bootstrapping Atlas, Chronos, Sentinel, Forge, and Aegis"
  bash "$(dirname "$0")/bootstrap-agents.sh"
}

install_cloudflare_tools(){
  info "[Cloudflare] Wrangler"
  mkdir -p "$NPM_USER_PREFIX/bin"
  run npm config set prefix "$NPM_USER_PREFIX" || true
  export PATH="$NPM_USER_PREFIX/bin:$PATH"
  run npm install -g wrangler || true
}

install_ollama(){
  info "[Ollama] runtime only"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    warn "Would install Ollama from official Linux installer"
  else
    curl -fsSL https://ollama.com/install.sh | sh
  fi
}

install_misc_ai_tools(){
  info "[AI tools] Claude + Perplexity + Cloudflare env scaffolding"
  mkdir -p "$HOME/.config/ai-dev" "$HOME/.local/share/applications"
  cat > "$HOME/.config/ai-dev/ai-tools.env" <<'ENVEOF'
export ANTHROPIC_API_KEY=
export OPENAI_API_KEY=
export PERPLEXITY_API_KEY=
export CLOUDFLARE_API_TOKEN=
export CLOUDFLARE_ACCOUNT_ID=
export AI_GATEWAY_URL=
ENVEOF
  cat > "$HOME/.local/share/applications/perplexity.desktop" <<'DESKEOF'
[Desktop Entry]
Type=Application
Name=Perplexity
Exec=xdg-open https://www.perplexity.ai/
Icon=web-browser
Terminal=false
Categories=Network;WebBrowser;
DESKEOF
}

gpu_detect(){
  if ! has lspci; then
    warn "lspci not found; skipping hardware GPU detection."
    GPU_VENDOR="none"
    return
  fi
  if lspci | grep -qi nvidia; then GPU_VENDOR="nvidia"; GPU_MODEL="$(lspci | grep -i nvidia | head -n1 | sed 's/.*NVIDIA //I')"; return; fi
  if lspci | grep -qi "intel.*vga\|intel.*display"; then GPU_VENDOR="intel"; GPU_MODEL="Intel iGPU"; return; fi
  if lspci | grep -qi amd; then GPU_VENDOR="amd"; GPU_MODEL="AMD GPU"; return; fi
  GPU_VENDOR="none"
}

nvidia_recommend(){
  if [[ "$GPU_VENDOR" != "nvidia" ]]; then
    GPU_DRIVER_RECOMMENDATION="No NVIDIA GPU detected; skip CUDA/NVIDIA driver changes."
    return
  fi
  if [[ "$OS_FAMILY" == "ubuntu" ]]; then
    GPU_DRIVER_RECOMMENDATION="Detected NVIDIA on an Ubuntu-family host. Recommended path: review Ubuntu/NVIDIA driver flow, install/verify driver first, then consider CUDA."
  elif [[ "$OS_FAMILY" == "debian" ]]; then
    GPU_DRIVER_RECOMMENDATION="Detected NVIDIA on a Debian-family host. Recommended path: install driver from Debian/NVIDIA-supported repo flow, verify, then consider CUDA."
  else
    GPU_DRIVER_RECOMMENDATION="Detected NVIDIA, but distro family is unclear. Manual review recommended."
  fi
}

profile_pick(){
  if [[ "$PROFILE" != "auto" ]]; then return; fi
  if is_virtualized; then PROFILE="vm"; return; fi
  if [[ "$GPU_VENDOR" == "nvidia" ]] && [[ ${ram_gb%.*} -ge 32 ]]; then PROFILE="workstation"; return; fi
  if [[ "$GPU_VENDOR" == "intel" ]]; then PROFILE="laptop"; return; fi
  PROFILE="server"
}

setup_ubuntu_pro(){
  if [[ "$OS_FAMILY" != "ubuntu" ]]; then
    info "[Ubuntu Pro] Skipped on non-Ubuntu-family host"
    return 0
  fi
  info "[Ubuntu Pro] Preparing client"
  pkg_install ubuntu-pro-client || pkg_install ubuntu-advantage-tools || true
  if [[ "$DRY_RUN" -eq 1 ]]; then
    warn "Would run Ubuntu Pro browser-based attach flow or token-based attach"
    return 0
  fi
  echo
  echo "Ubuntu Pro setup options:"
  echo "  1) Browser/web login flow (recommended)"
  echo "  2) Enter token manually"
  echo "  3) Skip for now"
  read -r -p "Choose [1/2/3]: " pro_choice
  case "$pro_choice" in
    1)
      info "Starting browser-based Ubuntu Pro attach flow"
      echo "Opening Ubuntu Pro attach page in your default browser..."
      open_url "https://ubuntu.com/pro/attach"
      sudo pro attach || true
      echo "Follow the on-screen code from the terminal, sign in with Ubuntu One, complete verification, and return here."
      pause_if_live "Press Enter after Ubuntu Pro attach completes in the terminal..."
      sudo pro status || true
      ;;
    2)
      read -r -p "Paste Ubuntu Pro token: " UBUNTU_PRO_TOKEN
      if [[ -n "${UBUNTU_PRO_TOKEN:-}" ]]; then
        sudo pro attach "$UBUNTU_PRO_TOKEN" --no-auto-enable || true
        sudo pro status || true
      fi
      ;;
    *)
      warn "Ubuntu Pro skipped by user"
      ;;
  esac
}

setup_cloudflare_browser_login(){
  info "[Cloudflare] Browser login + AI Gateway guidance"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    warn "Would run wrangler login and then prompt for AI Gateway setup in browser"
    return 0
  fi
  export PATH="$NPM_USER_PREFIX/bin:$PATH"
  if has wrangler; then
    echo "Opening Cloudflare dashboard in your default browser before Wrangler login..."
    open_url "https://dash.cloudflare.com/"
    pause_if_live "Press Enter after the dashboard opens, then the agent will start Wrangler login..."
    echo "A browser login may open locally or provide a local URL such as http://localhost:8787 for Cloudflare auth."
    wrangler login || true
    echo "Opening Cloudflare AI Gateway area in your browser..."
    open_url "https://dash.cloudflare.com/?to=/:account/ai/ai-gateway"
  else
    warn "wrangler still unavailable; install step likely failed"
  fi
  cat <<'CFEOF'
Next browser steps for Cloudflare:
1. Sign in to the Cloudflare dashboard.
2. Open AI Gateway in your account.
3. Create or confirm a gateway for LLM/API traffic.
4. Copy the gateway endpoint and account context.
5. Save them into ~/.config/ai-dev/ai-tools.env as AI_GATEWAY_URL and CLOUDFLARE_ACCOUNT_ID.
CFEOF
}

verify_and_report(){
  cat > "$REPORT_FILE" <<EOF
DEXTOR-GEMINI-CLI Report
===================
Hostname: $HOSTNAME_FQDN
Distro: $DISTRO
Codename: $CODENAME
OS family: $OS_FAMILY
Arch: $ARCH
Kernel: $KERNEL
RAM(GB): $ram_gb
Profile: $PROFILE
GPU vendor: $GPU_VENDOR
GPU model: $GPU_MODEL
GPU recommendation: $GPU_DRIVER_RECOMMENDATION
Mode: $MODE
Dry run: $DRY_RUN
Install root: $INSTALL_ROOT
EOF
  {
    echo
    echo "Validation"
    echo "=========="
    command -v docker >/dev/null 2>&1 && docker --version || true
    command -v node >/dev/null 2>&1 && node --version || true
    command -v python3 >/dev/null 2>&1 && python3 --version || true
    PATH="$NPM_USER_PREFIX/bin:$PATH" command -v wrangler >/dev/null 2>&1 && PATH="$NPM_USER_PREFIX/bin:$PATH" wrangler --version || true
    command -v gh >/dev/null 2>&1 && gh --version | head -n1 || true
    command -v ollama >/dev/null 2>&1 && ollama --version || true
    [[ "$OS_FAMILY" == "ubuntu" ]] && sudo pro status || true
  } >> "$REPORT_FILE" 2>&1
}

pre_install_cleanup(){
  info "[Cleanup] Removing conflicting GPG keys and source lists..."
  sudo rm -f /etc/apt/sources.list.d/vscode.list /etc/apt/sources.list.d/vscode.sources /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/1password.list
  sudo rm -f /usr/share/keyrings/ms-vscode.gpg /usr/share/keyrings/microsoft.gpg /etc/apt/keyrings/docker.gpg /usr/share/keyrings/1password-archive-keyring.gpg
}

main(){
  info "Starting DEXTOR-GEMINI-CLI on $HOSTNAME_FQDN"
  info "Detected distro=$DISTRO codename=$CODENAME family=$OS_FAMILY arch=$ARCH kernel=$KERNEL ram=${ram_gb}GB"
  gpu_detect
  nvidia_recommend
  profile_pick
  info "Selected profile: $PROFILE"
  info "GPU: $GPU_VENDOR $GPU_MODEL"
  info "$GPU_DRIVER_RECOMMENDATION"
  pre_install_cleanup
  apt_common
  install_docker_engine
  install_node_stack
  install_python_stack
  install_editors
  install_github_cli
  install_gitlab_cli
  install_1password_cli
  install_box_cli
  install_cloudflare_tools
  install_ollama
  install_misc_ai_tools
  bootstrap_sub_agents
  setup_ubuntu_pro
  setup_cloudflare_browser_login
  verify_and_report
  info "Completed. Report: $REPORT_FILE"
  info "Re-login may be required for docker group and updated shell PATH entries."
}

main "$@"
