#!/bin/bash

# Simple wrapper for notify-send with plain-English narration.
# Usage: ./notify-wrapper.sh <component> <status_or_error>

COMPONENT=$1
STATUS=$2

# Get plain English message
MESSAGE=$(bash "$(dirname "$0")/plain-english-narrator.sh" "$COMPONENT" "$STATUS")

# Determine icon and title based on component
case $COMPONENT in
    "sentinel") TITLE="Environment Guard"; ICON="utilities-terminal" ;;
    "forge")    TITLE="Git Guard";         ICON="emblem-shared" ;;
    "aegis")    TITLE="Network Guard";     ICON="network-security" ;;
    "vault")    TITLE="Vault Guard";       ICON="security-high" ;;
    "box")      TITLE="Box Guard";         ICON="box-logo" ;;
    *)          TITLE="Project Alert";     ICON="dialog-information" ;;
esac

# Send notification if display is available, otherwise log to stdout/stderr
if [[ -n "$DISPLAY" ]]; then
    notify-send -i "$ICON" "$TITLE" "$MESSAGE"
else
    echo "[$TITLE] $MESSAGE"
fi
