<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# AI Dev Setup Run Guide

This guide explains how to run the generated `ai-dev-setup.sh` installer safely on Ubuntu or Debian-family systems, including a dry-run workflow before making any changes. The installer is designed for Ubuntu and Debian-family systems, installs Docker Engine and related tooling through the official Docker repository flow, installs Ollama through its Linux installer, and uses guided detection for NVIDIA/CUDA rather than forcing driver changes automatically.[^1][^2][^3][^4][^5]

## What the script does

The script prepares a developer and homelab environment by installing core CLI utilities, Python tooling, Node tooling, Docker Engine with Compose and Buildx, VS Code, GitHub CLI, Cloudflare Wrangler, Ollama, and configuration scaffolding for AI-oriented workflows. It also detects the machine profile, records system details such as distro, kernel, RAM, and GPU, and writes an install report so the machine can be reviewed after execution.[^2][^3][^4][^5][^6][^7][^1]

## Before running

1. Copy the script to the target machine and make it executable:
```bash
chmod +x ai-dev-setup.sh
```

2. Ensure the machine has:

- `sudo` access.
- Internet access.
- A Debian-family base such as Ubuntu or Debian.
- Enough free disk space for packages, containers, and later LLM/model downloads.

3. For NVIDIA systems, keep guided mode unless the driver/CUDA path has already been validated for that host, because NVIDIA’s Linux installation flow depends on distro and repository alignment.[^4][^5]

## Dry-run first

A dry run prints the commands that would be executed without applying the changes. This is the safest first step for laptops, workstations, VMs, and shared lab systems.

Run:

```bash
./ai-dev-setup.sh --dry-run
```

Or specify a profile explicitly:

```bash
./ai-dev-setup.sh --dry-run --profile=laptop
./ai-dev-setup.sh --dry-run --profile=workstation
./ai-dev-setup.sh --dry-run --profile=vm
```

Use dry-run to confirm:

- The distro was detected correctly.
- The machine profile looks right.
- Docker repository commands match the host distro.
- Ollama installation is planned but no models are auto-pulled.
- NVIDIA systems only show recommendations instead of driver replacement.[^3][^5][^1][^2][^4]


## Run for real

After reviewing the dry-run output, execute the script normally:

```bash
./ai-dev-setup.sh
```

A profile can also be forced when auto-detection is not ideal:

```bash
./ai-dev-setup.sh --profile=laptop
./ai-dev-setup.sh --profile=workstation
./ai-dev-setup.sh --profile=hpc
./ai-dev-setup.sh --profile=server
./ai-dev-setup.sh --profile=vm
```

The script defaults to guided mode, which means it installs the general toolchain while leaving NVIDIA/CUDA decisions as recommendations instead of making system-level GPU changes automatically.[^5][^4]

## Useful options

| Option | Purpose |
| :-- | :-- |
| `--dry-run` | Print planned commands without changing the machine. |
| `--profile=auto` | Let the script choose a profile from detected hardware and virtualization state. |
| `--profile=laptop` | Force a laptop-style install path. |
| `--profile=workstation` | Force a workstation path for stronger systems, typically those with more RAM or discrete GPU resources. |
| `--profile=hpc` | Force an HPC-oriented label for compute nodes or lab workstations. |
| `--profile=vm` | Force a VM profile. |
| `--mode=guided` | Keep GPU/CUDA handling recommendation-only. |
| `--mode=detect` | Similar to guided usage, emphasizing detection and reporting. |
| `--mode=full-auto` | Reserved for future extension; use carefully if GPU automation is later added. |

## Recommended workflow by machine type

### HP Spectre or similar laptop

1. Start with dry-run:
```bash
./ai-dev-setup.sh --dry-run --profile=laptop
```

2. Run the installer:
```bash
./ai-dev-setup.sh --profile=laptop
```

3. Sign out and back in after Docker installation so the Docker group change applies cleanly, which is typical after adding the current user to the Docker group.[^1][^2]

### NVIDIA workstation or HPC box

1. Start with dry-run:
```bash
./ai-dev-setup.sh --dry-run --profile=workstation
```

2. Review the GPU recommendation shown by the script.
3. Run the installer:
```bash
./ai-dev-setup.sh --profile=workstation
```

4. Only after the base tooling is installed, review the recommended NVIDIA/CUDA path for that host and verify with `nvidia-smi` after any manual driver work.[^4][^5]

### VM or lab utility box

1. Dry-run:
```bash
./ai-dev-setup.sh --dry-run --profile=vm
```

2. Execute:
```bash
./ai-dev-setup.sh --profile=vm
```

VMs are useful places to validate package flow, repository setup, and shell scaffolding before touching a GPU host.[^2][^1]

## After the run

The script writes logs and a machine report under the install root, which defaults to `~/.local/share/ai-dev-setup`. Review these files after each run:

```bash
cat ~/.local/share/ai-dev-setup/report.txt
less ~/.local/share/ai-dev-setup/install.log
```

Then validate the main tools:

```bash
docker --version
docker compose version
node --version
python3 --version
gh --version
wrangler --version
ollama --version
```

For Docker, the repository-backed Ubuntu and Debian installation path provides Docker Engine, Compose plugin, and Buildx plugin when those packages are installed from the official Docker repositories. For Ollama, the generated script intentionally stays conservative and installs the runtime without automatically pulling any models.[^3][^1][^2]

## Suggested next checks

Run these after the installer finishes:

```bash
docker run hello-world
code --version
gh auth status || true
wrangler login
```

For AI environment scaffolding, inspect the generated shell environment template:

```bash
cat ~/.config/ai-dev/ai-tools.env
```

This file is where API keys and service-specific environment variables can be filled in later for Claude, Perplexity, Cloudflare, and related tooling. Cloudflare Wrangler is commonly installed through npm, and GitHub CLI has an official Linux package flow for Debian-family systems.[^6][^7]

## Safety notes

- Use dry-run on every new machine class first.
- Keep guided mode for GPU hosts unless a machine-specific NVIDIA/CUDA path has already been validated.
- Reboot or re-login after major system package changes when needed, especially after Docker group membership updates.[^5][^1][^2][^4]
- Pull Ollama models manually after confirming RAM, disk, and GPU suitability, because the configured policy is conservative and avoids automatic model downloads.[^3]

<div align="center">⁂</div>

[^1]: https://docs.docker.com/engine/install/ubuntu/

[^2]: https://docs.docker.com/engine/install/debian/

[^3]: https://docs.ollama.com/linux

[^4]: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/

[^5]: https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/ubuntu.html

[^6]: https://developers.cloudflare.com/workers/wrangler/install-and-update/

[^7]: https://github.com/imjasonh/gh-cli/blob/trunk/docs/install_linux.md

