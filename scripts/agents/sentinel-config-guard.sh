#!/bin/bash

# sentinel-config-guard.sh
# Sentinel Config Guard - Monitors Docker, Dev Containers, and Paths.
# Can perform active repair if --fix is passed.

FIX_MODE=0
[[ "$1" == "--fix" ]] && FIX_MODE=1

NOTIFY_WRAPPER="$(dirname "$0")/../utils/notify-wrapper.sh"
INSTALLER="$(dirname "$0")/../install/ai-dev-agent.sh"

report_error() {
    local status=$1
    if [[ "$FIX_MODE" -eq 1 ]]; then
        echo "[INFO] Sentinel is attempting to fix: $status"
        case $status in
            "docker_down")
                sudo systemctl start docker || bash "$INSTALLER"
                ;;
            "path_issue")
                # Add missing paths to bashrc if possible
                echo 'export PATH="$HOME/.local/npm-global/bin:$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
                ;;
        esac
    else
        bash "$NOTIFY_WRAPPER" "sentinel" "$status"
    fi
}

# 1. Check Docker status
if ! docker info > /dev/null 2>&1; then
    report_error "docker_down"
fi

# 2. Check for suspicious path issues
REQUIRED_PATHS=("/usr/local/bin" "$HOME/.local/npm-global/bin" "$HOME/.local/bin")
for p in "${REQUIRED_PATHS[@]}"; do
    if [[ ":$PATH:" != *":$p:"* ]]; then
        report_error "path_issue"
        break
    fi
done

# 3. Check Dev Container CLI
if ! command -v devcontainer > /dev/null 2>&1; then
    if [[ "$FIX_MODE" -eq 1 ]]; then
        echo "[INFO] Sentinel is installing @devcontainers/cli..."
        npm install -g @devcontainers/cli
    else
        bash "$NOTIFY_WRAPPER" "sentinel" "devcontainer_missing"
    fi
fi
