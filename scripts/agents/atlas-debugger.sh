#!/bin/bash

# atlas-debugger.sh
# Atlas Debugger - Checks missing dependencies, CLIs, and main-task health.

NOTIFY_WRAPPER="$(dirname "$0")/../notify-wrapper.sh"

check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "missing_$1"
        return 1
    fi
    return 0
}

MISSING=()
check_cmd "docker" || MISSING+=("docker")
check_cmd "gh" || MISSING+=("github_cli")
check_cmd "glab" || MISSING+=("gitlab_cli")
check_cmd "wrangler" || MISSING+=("cloudflare_wrangler")
check_cmd "op" || MISSING+=("1password_cli")
check_cmd "ollama" || MISSING+=("ollama")

if [[ ${#MISSING[@]} -gt 0 ]]; then
    # Report first missing tool for simplicity in plain English
    bash "$NOTIFY_WRAPPER" "atlas" "missing_${MISSING[0]}"
fi
