---
title: "Box Backup"
description: "Automated project 'DNA' backup for DEXTOR-GEMINI-CLI to Box.com."
---

The **DEXTOR-GEMINI-CLI** includes a dedicated backup agent, **Box Guard**, which ensures your project's configuration, scripts, and documentation are safely stored in Box.com.

## What is Backed Up?

To keep the backup lean and efficient, we only include the project's "DNA":
- **Documentation:** All `.md` files in the root and `docs/`.
- **Setup & Logic:** All scripts in `scripts/`.
- **Configuration:** Templates and active configs in `main-config/`.
- **Automation:** Systemd unit files in `systemd/user/`.

**Excluded:** Downloadable assets, large models (`.ai-hub`), node modules, virtual environments, and git history.

## Box Guard Agent

The backup is handled by:
`scripts/agents/box-backup.sh`

### How it Works
1.  **Staging:** Collects relevant files into a temporary directory.
2.  **Packaging:** Creates a compressed `.tar.gz` archive.
3.  **Upload:** Uses the **Box CLI** to upload the archive to your specified Box folder.

### Automation
A systemd user timer (`box.timer`) triggers the backup agent **daily**.

## Setup Instructions

### 1. Install Box CLI
The project installer automatically handles this. If you need to do it manually:
```bash
npm install -g @box/cli
```

### 2. Authenticate
You must sign in to your Box account for the agent to work:
```bash
box login
```

### 3. Folder Configuration
Edit `scripts/agents/box-backup.sh` and update the `parent-id` with your desired Box folder ID.

## Plain English Alerts
If the backup fails or requires your attention, you'll receive a notification:
*"I've prepared a backup of your project's DNA, but I need you to sign in to Box or provide a folder ID to finish the save."*
