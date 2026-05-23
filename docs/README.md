# Project Guide: DEXTOR-GEMINI-CLI & Agents

Welcome! This document explains how this project is structured, how to install it, and how the background "Helpers" (Agents) work.

## 🚀 Quick Start (Installation)

To set up the entire environment (Docker, Node, Python, VS Code, AI Tools), run the main agent:

```bash
chmod +x scripts/install/ai-dev-agent.sh
./scripts/install/ai-dev-agent.sh
```

**Options:**
- `--dry-run`: See what will happen without making changes.
- `--profile=laptop|workstation|vm`: Manually select a machine type.

---

## 📖 Official Documentation (Mintlify)

Detailed documentation, including agent mechanics and tool guides, is available in the `docs/mintlify` directory.

### Running Locally
To view the beautiful, interactive version of this documentation:
1.  **Install Mintlify CLI:** `npm install -g mintlify`
2.  **Start Dev Server:**
    ```bash
    cd docs/mintlify
    mintlify dev
    ```
3.  **View:** Open `http://localhost:3000` in your browser.

---

## 🛠️ Repository Structure

- `src/`: Source code (TypeScript in `src/ts`, Python in `src/py`).
- `tests/`: Project tests.
- `scripts/install/`: Environment setup and installation scripts.
- `scripts/agents/`: Modular background monitoring agents.
- `systemd/user/`: Configuration for automated background tasks.
- `main-config/`: Version-controlled configuration templates.
- `docs/`: User guides and documentation.

---

## 🤖 The Helpers (Automated Monitoring)

We have five special helpers (Agents) that run in the background. They make sure everything is working correctly and will send a message to your screen if they find a problem.

### 1. 🛡️ Sentinel (Environment Guard)
- **What it does:** Checks if the "Docker" app is running and ensures the computer's "map" (Paths) is correct.
- **Message:** "The 'Docker' app is currently sleeping..."

### 2. ⚒️ Forge (Work Guard)
- **What it does:** Monitors your saved work on GitHub/GitLab and checks for "disagreements" (Merge Conflicts).
- **Message:** "Your GitHub keys aren't working..." or "There's a disagreement between your work..."

### 3. 🌐 Aegis (Internet Guard)
- **What it does:** Checks if the computer can talk to the internet securely via Cloudflare.
- **Message:** "Cloudflare is currently away from its post."

### 4. 🔍 Atlas (Debugger)
- **What it does:** Checks if any important tools (like the CLIs) have gone missing.
- **Message:** "Atlas noticed the 'Docker' toolbox is missing."

### 5. ⏳ Chronos (Upgrader)
- **What it does:** Automatically keeps your tools and system up to date every day.
- **Why it matters:** Ensures you always have the latest security fixes and features.

### 6. 🧩 MCP Manager
- **What it does:** Utilities to lookup and install Model Context Protocol (MCP) servers.
- **Commands:** `bash scripts/agents/mcp-manager.sh lookup <query>`

### 7. 🗺️ Forge Lifecycle
- **What it does:** Performs automated Git maintenance and generates a project index.
- **Index Location:** `state/index.txt`


---

## 👵 Wife-Friendly Mode (Plain English)

All technical errors are translated into simple terms by the **Plain English Narrator** (`scripts/plain-english-narrator.sh`). 

**What to do if you see a message?**
Don't worry! The message will tell you exactly what's wrong. Usually, checking your internet or restarting the computer fixes 90% of issues. If it persists, just let me know!
