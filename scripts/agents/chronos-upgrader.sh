#!/bin/bash

# chronos-upgrader.sh
# Chronos Upgrader - Runs updates on first login and daily.

LOG_FILE="$HOME/.local/share/dextor-gemini-cli/upgrade.log"

echo "[$(date)] Starting daily upgrade..." >> "$LOG_FILE"

# Update apt
sudo apt-get update -y >> "$LOG_FILE" 2>&1
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y >> "$LOG_FILE" 2>&1

# Update Node globals
export PATH="$HOME/.local/npm-global/bin:$PATH"
npm update -g >> "$LOG_FILE" 2>&1

# Update Python tools (via pipx)
pipx upgrade-all >> "$LOG_FILE" 2>&1

echo "[$(date)] Daily upgrade complete." >> "$LOG_FILE"
