---
title: "The Guards (Agents)"
description: "Overview of the background agents that monitor and maintain DEXTOR-GEMINI-CLI."
---

The system maintains its health via modular background agents, which are enabled as user-level `systemd` timers.

## The Guards

| Agent | Purpose | Trigger |
| :--- | :--- | :--- |
| **Sentinel** | Monitors Docker integrity and PATH health. | Every hour (`sentinel.timer`) |
| **Forge** | Watches Git authentication and resolves merge conflicts. | Every 30 mins (`forge.timer`) |
| **Aegis** | Checks Cloudflare connectivity and AI Gateway status. | Every 15 mins (`aegis.timer`) |
| **Atlas** | Debugs missing dependencies or task failures. | Every 4 hours (`atlas.timer`) |
| **Chronos** | Performs daily system and tool upgrades. | Daily (`chronos.timer`) |
| **Vault** | Ensures 1Password session connectivity. | Every hour (`vault.timer`) |

## How They Work

Each agent is a standalone shell script located in `scripts/agents/`. They are designed to be fast, non-intrusive, and purely diagnostic.

When an agent detects an issue, it:
1.  Logs the event to its internal log file.
2.  Routes the event through the **Plain English Narrator**.
3.  Sends a desktop notification via the **Notify Wrapper**.
