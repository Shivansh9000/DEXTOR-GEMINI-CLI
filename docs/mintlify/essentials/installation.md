---
title: "Installation"
description: "How to set up DEXTOR-GEMINI-CLI on your machine."
---

The environment is set up using a single, profile-aware installer script.

## Quick Start

To initialize or update the entire environment, run the main agent:

```bash
chmod +x scripts/install/ai-dev-agent.sh
./scripts/install/ai-dev-agent.sh
```

## Installation Options

- `--dry-run`: See what will happen without making any changes to your system.
- `--profile=auto|laptop|workstation|vm`: Manually force a specific machine profile.
- `--mode=guided|detect|full-auto`: Set the level of automation for GPU/CUDA handling.

## What it Installs

- **Core Utilities:** `ripgrep`, `fzf`, `htop`, `tmux`, `direnv`, etc.
- **Node.js Stack:** Node.js v22+, `npm`, `pnpm`, `bun`.
- **Python Stack:** Python 3.12, `uv`, `poetry`, `pipx`.
- **Containers:** Docker Engine, Compose, Buildx.
- **AI Runtimes:** Ollama (Runtime), Scaffolding for Claude/Perplexity.
- **CLIs:** 1Password CLI (`op`), GitHub CLI (`gh`), GitLab CLI (`glab`), Cloudflare (`wrangler`).

## Post-Installation

After the installer completes, you may need to:
1.  **Re-login:** To apply group changes (like `docker`) and updated shell `PATH` entries.
2.  **Authenticate CLIs:** Run `gh auth login`, `op signin`, and `wrangler login`.
