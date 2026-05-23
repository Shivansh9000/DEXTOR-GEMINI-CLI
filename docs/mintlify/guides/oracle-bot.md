---
title: "Oracle Discord Bot"
description: "Remote control DEXTOR-GEMINI-CLI via iPhone/iOS."
---

The **DEXTOR-GEMINI-CLI** includes a dedicated Discord bot, **Oracle**, which allows you to monitor and control your system remotely using the Discord app on your mobile device.

## 📱 Features

- **`!status`**: Get a live report of all background agent timers and their health.
- **`!run <command>`**: Execute safe, pre-defined commands or local scripts.
- **Remote Monitoring**: Receive project alerts directly on your phone.

## 🛠️ Setup Instructions

### 1. Create a Discord Bot
1.  Go to the [Discord Developer Portal](https://discord.com/developers/applications).
2.  Create a **New Application** and name it "Oracle".
3.  Navigate to the **Bot** tab and click **Reset Token** to get your **Bot Token**.
4.  Enable **Message Content Intent** under the Privileged Gateway Intents section.
5.  Invite the bot to your server using the URL Generator (choose `bot` and `Administrator` permissions for simplicity).

### 2. Configure Credentials
Update your `~/.config/ai-dev/ai-tools.env` file with the bot's credentials:

```bash
export DISCORD_TOKEN="your_bot_token_here"
export DISCORD_ALLOWED_USER_ID="your_personal_discord_id"
```

### 3. Activate Oracle
The installer sets up the background service for you. Once you have added your credentials, start the bot:

```bash
systemctl --user enable --now oracle.service
```

## 🔒 Security & Safety
- **Allowed User ID:** Oracle only responds to messages from the specific Discord User ID defined in your config.
- **Safe Commands:** Commands like `!run` are restricted to a whitelist of safe operations (e.g., `docker ps`, `git status`) and project scripts. Unsafe commands are automatically blocked.

## 👵 Wife-Friendly Remote
Oracle uses the same **Plain English Narrator** logic, so even remote status reports are easy to read and understand.
