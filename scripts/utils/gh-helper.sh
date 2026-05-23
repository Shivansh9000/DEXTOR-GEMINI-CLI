#!/bin/bash

# gh-helper.sh
# Utility to interact with GitHub CLI for authentication and common tasks.

# 1. Ensure user is signed in
check_auth() {
    if ! gh auth status &> /dev/null; then
        echo "[ERROR] GitHub CLI is not authenticated."
        echo "[HINT] Run 'gh auth login' to authenticate."
        exit 1
    fi
}

# 2. Get current user
get_user() {
    gh api user -q .login
}

# 3. Create a repository
# Usage: ./gh-helper.sh create <repo_name> <description>
create_repo() {
    local name=$1
    local desc=$2
    gh repo create "$name" --description "$desc" --public
}

# 4. Clone a repository
# Usage: ./gh-helper.sh clone <repo_url_or_name>
clone_repo() {
    local repo=$1
    gh repo clone "$repo"
}

case $1 in
    "check") check_auth; echo "[INFO] GitHub CLI is authenticated as $(get_user)." ;;
    "user") get_user ;;
    "create") create_repo "$2" "$3" ;;
    "clone") clone_repo "$2" ;;
    *) echo "Usage: $0 {check|user|create|clone}" ;;
esac
