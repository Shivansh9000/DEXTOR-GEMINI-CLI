#!/bin/bash

# vault-guard.sh
# Vault Guard - Monitors 1Password CLI session and connectivity.

NOTIFY_WRAPPER="$(dirname "$0")/../notify-wrapper.sh"

# 1. Check if op is installed
if ! command -v op &> /dev/null; then
    # Atlas already checks for missing tools, but we can double-down or let Atlas handle it.
    # We'll focus on the session here.
    exit 0
fi

# 2. Check if user is signed in to 1Password
if ! op whoami &> /dev/null; then
    bash "$NOTIFY_WRAPPER" "vault" "session_locked"
fi
