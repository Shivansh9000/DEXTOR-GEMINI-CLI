#!/bin/bash

# forge-lifecycle.sh
# Forge Lifecycle Agent - Repository maintenance and indexing.

INDEX_FILE="$(dirname "$0")/../../state/index.txt"
mkdir -p "$(dirname "$INDEX_FILE")"

# 1. Guard (Auth & Conflicts)
run_guard() {
    NOTIFY_WRAPPER="$(dirname "$0")/../utils/notify-wrapper.sh"
    # Check Git Auth
    if command -v gh > /dev/null 2>&1; then
        if ! gh auth status > /dev/null 2>&1; then
            bash "$NOTIFY_WRAPPER" "forge" "git_auth_fail"
        fi
    fi
    # Check for merge conflicts
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        if git ls-files -u | grep -q "^"; then
            bash "$NOTIFY_WRAPPER" "forge" "conflict"
        fi
    fi
}

# 2. Maintenance
run_maintenance() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "[INFO] Forge is performing Git maintenance..."
        git fetch -p > /dev/null 2>&1
        git gc --auto > /dev/null 2>&1
    fi
}

# 2. Indexing
generate_index() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "[INFO] Forge is generating codebase index..."
        echo "Project Index (Last updated: $(date))" > "$INDEX_FILE"
        echo "======================================" >> "$INDEX_FILE"
        git ls-files >> "$INDEX_FILE"
    fi
}

# 3. Enforce Config
enforce_config() {
    echo "[INFO] Forge is enforcing standard Git configs..."
    git config --global pull.rebase true
    git config --global core.editor "code --wait"
}

case $1 in
    "guard") run_guard ;;
    "maintain") run_maintenance ;;
    "index") generate_index ;;
    "config") enforce_config ;;
    "all") run_guard; run_maintenance; generate_index; enforce_config ;;
    *) echo "Usage: $0 {guard|maintain|index|config|all}" ;;
esac
