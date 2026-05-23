#!/bin/bash

# op-helper.sh
# Utility to interact with 1Password CLI for authentication and secret retrieval.

# 1. Ensure user is signed in
check_session() {
    if ! op whoami &> /dev/null; then
        echo "[ERROR] 1Password session is locked or not signed in."
        echo "[HINT] Run 'op signin' to authenticate."
        exit 1
    fi
}

# 2. Fetch a secret
# Usage: ./op-helper.sh get <vault> <item> <field>
get_secret() {
    local vault=$1
    local item=$2
    local field=$3
    op item get "$item" --vault "$vault" --field "$field"
}

# 3. Inject secrets into env file
# Usage: ./op-helper.sh inject <template_file> <output_file>
inject_secrets() {
    local template=$1
    local output=$2
    op inject -i "$template" -o "$output"
}

case $1 in
    "check") check_session; echo "[INFO] 1Password session is active." ;;
    "get") get_secret "$2" "$3" "$4" ;;
    "inject") inject_secrets "$2" "$3" ;;
    *) echo "Usage: $0 {check|get|inject}" ;;
esac
