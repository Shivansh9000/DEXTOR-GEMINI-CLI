#!/bin/bash

# cloudflare-helper.sh
# Utility to interact with Cloudflare Wrangler CLI.

export PATH="$HOME/.local/npm-global/bin:$PATH"

# 1. Ensure user is logged in
check_auth() {
    if ! wrangler whoami &> /dev/null; then
        echo "[ERROR] Cloudflare Wrangler is not authenticated."
        echo "[HINT] Run 'wrangler login' to authenticate."
        exit 1
    fi
}

# 2. Start a local development server
# Usage: ./cloudflare-helper.sh dev <script_path>
dev_server() {
    local path=$1
    wrangler dev "$path"
}

# 3. Deploy a worker
# Usage: ./cloudflare-helper.sh deploy <script_path>
deploy_worker() {
    local path=$1
    wrangler deploy "$path"
}

# 4. Check AI Gateway status
# Note: This is more of a placeholder as Wrangler handles AI Gateway indirectly
check_ai_gateway() {
    echo "[INFO] Checking AI Gateway configuration in ~/.config/ai-dev/ai-tools.env..."
    if grep -q "AI_GATEWAY_URL=." "$HOME/.config/ai-dev/ai-tools.env"; then
        echo "[SUCCESS] AI Gateway URL is configured."
    else
        echo "[WARN] AI Gateway URL is missing or empty."
    fi
}

case $1 in
    "check") check_auth; echo "[INFO] Cloudflare Wrangler is authenticated." ;;
    "gateway") check_ai_gateway ;;
    "dev") dev_server "$2" ;;
    "deploy") deploy_worker "$2" ;;
    *) echo "Usage: $0 {check|gateway|dev|deploy}" ;;
esac
