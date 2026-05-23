---
title: "Introduction"
description: "Welcome to DEXTOR-GEMINI-CLI, a self-monitoring, autonomous workspace."
---

The **DEXTOR-GEMINI-CLI** is an autonomous, self-monitoring, polyglot development environment optimized for AI-assisted software engineering. It is designed to be easily maintained by AI agents and transparent to non-technical users.

## Key Features

- **Agent-Led Maintenance:** A suite of background "Guards" monitor system health, security, and updates.
- **Polyglot Support:** First-class support for Node.js (v22+) and Python (3.10+).
- **Self-Healing:** Automated detection and reporting of configuration issues.
- **Plain English Communication:** Technical errors are translated into simple, friendly language.
- **Secure by Default:** Mandatory integration with 1Password for all secrets.

## Core Mandates

1.  **Read Master Documentation:** Always check `GEMINI.md` and this documentation first.
2.  **Use the Unified Installer:** Use `scripts/install/ai-dev-agent.sh` for all environment setup.
3.  **Modular Agents:** Maintenance tasks must be handled by the modular agents in `scripts/agents/`.
4.  **Validation is Mandatory:** Always run the project's native validation commands after making changes.
