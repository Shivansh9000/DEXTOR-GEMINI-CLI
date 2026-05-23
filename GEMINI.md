# Project Master Guidelines: DEXTOR-GEMINI-CLI

## 🎯 Objective
This project is an autonomous, self-monitoring, polyglot development environment optimized for AI-assisted software engineering on Ubuntu (24-26) and Debian-family systems. It is designed to be:
1.  **Agent-Friendly:** Highly structured for automated maintenance and navigation.
2.  **Robust:** Self-healing via background "Guards."
3.  **Transparent:** Narrates technical events in "Plain English" for non-technical users.

---

## 📂 Repository Structure

- `src/`: Core logic. `src/ts/` (Node.js/TypeScript), `src/py/` (Python).
- `tests/`: Automated tests. `tests/ts/` (Vitest), `tests/py/` (Pytest).
- `scripts/`:
    - `install/`: Robust, profile-aware installer (`ai-dev-agent.sh`).
    - `agents/`: Modular monitoring sub-agents (Atlas, Chronos, Sentinel, Forge, Aegis, Vault).
    - `utils/`: Core utilities (`op-helper.sh`, `gh-helper.sh`, `cloudflare-helper.sh`, `ssh-helper.sh`, `hf-helper.sh`).
- `systemd/user/`: Systemd unit files for background automation.
- `main-config/`: Version-controlled configuration templates (e.g., `ai-tools.env.template`).
- `docs/`: Master documentation, "Wife-Friendly" guides, and Mintlify sources.

---

## 📖 Documentation (Mintlify)
The official documentation is powered by Mintlify and located in `docs/mintlify`.
To run the documentation locally:
1. `cd docs/mintlify`
2. `mintlify dev`

---

## 💻 Machine Profiles
The setup automatically detects hardware and applies one of three profiles:
- **Laptop:** Optimized for Intel iGPU and standard resources (e.g., HP Spectre).
- **Workstation:** Enhanced for NVIDIA GPU/HPC workloads (>32GB RAM).
- **VM:** Minimal setup for virtualized lab environments.

---

## 🤖 Agent Workflow (Directives)

1.  **Read Master Documentation:** Always check `GEMINI.md` and `docs/README.md` first.
2.  **Unified Installer:** Use `scripts/install/ai-dev-agent.sh` for all environment setup. It handles Docker GPG conflicts and npm permissions automatically.
3.  **Modular Agents:** Maintenance (updates, health checks) is strictly handled by agents in `scripts/agents/`.
4.  **Plain English Communication:** User-facing alerts **must** be routed through `scripts/utils/plain-english-narrator.sh`.
5.  **Validation is Mandatory:** 
    - TypeScript: `npm run lint && npm run type-check && npm test`
    - Python: `ruff check . && PYTHONPATH=. pytest`
6.  **Surgical Updates:** Prefer the `replace` tool over `write_file` for existing codebase modifications.

---

## 🛡️ Monitoring & Self-Healing
Health is maintained via user-level systemd timers:
- **Sentinel:** Monitors Docker integrity and PATH health.
- **Forge Lifecycle:** Unified agent for Git hygiene, authentication monitoring, merge conflict resolution, and codebase indexing.
- **Aegis:** Checks Cloudflare connectivity and AI Gateway status.
- **Atlas:** Debugs missing dependencies or task failures.
- **Chronos:** Performs daily system and tool upgrades.
- **Vault:** Ensures 1Password session connectivity.
- **Oracle:** Discord bot for remote control via iOS/iPhone.
- **Box:** Automated project "DNA" backup (scripts, config, docs) to Box.com.
- **MCP Manager:** Installs and manages Model Context Protocol servers.

---

## 🧩 Installed MCP Servers
The following MCP servers are configured in `~/.config/gemini-cli/mcp.json`:
- **GitHub:** Repository management and issue tracking.
- **GitLab:** Comprehensive GitLab integration.
- **Vercel:** Deployment and project monitoring.
- **Webflow:** CMS and site management.
- **Cloudflare:** Worker and network management.
- **Google Search:** Real-time web search capabilities.
- **Google Maps:** Location and place data.
- **Google Workspace:** Drive, Docs, Calendar, and Gmail integration.
- **Google Stitch:** UI design and "Design DNA" retrieval.
- **Perplexity:** Real-time web search and reasoning.
- **Memory:** Enhanced context and memory retention for agents.
- **Comet:** AI-powered agentic browsing experience.

---

## 🌐 Browsing & UI Tools
- **Comet Browser:** Integrated as a desktop web-app via `scripts/utils/comet-helper.sh`.
- **Google Stitch:** UI design and "Design DNA" retrieval.

- **Node.js:** v22+ mandatory (for Wrangler compatibility). Use `~/.local/npm-global` for binaries.
- **Python:** 3.10+ managed via `uv` and `poetry`.
- **Containers:** Docker Engine (not Desktop) preferred for homelab consistency.
- **Secrets:** 1Password CLI (`op`) is the mandatory source of truth. Use `op-helper.sh` for injection.
- **CLIs:** GitHub (`gh`), GitLab (`glab`), and Cloudflare (`wrangler`) must be configured via their respective helpers in `scripts/utils/`.
