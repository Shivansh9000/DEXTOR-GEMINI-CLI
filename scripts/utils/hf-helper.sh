#!/bin/bash

# hf-helper.sh
# Utility to interact with Hugging Face CLI (hf).

# 1. Ensure user is logged in
check_auth() {
    if ! hf auth whoami &> /dev/null; then
        echo "[ERROR] Hugging Face is not authenticated."
        echo "[HINT] Run 'hf auth login' to authenticate."
        exit 1
    fi
}

# 2. Download a model
# Usage: ./hf-helper.sh download <repo_id>
download_model() {
    local repo=$1
    echo "[INFO] Downloading model: $repo..."
    hf download "$repo"
}

# 3. List models
list_models() {
    hf models ls
}

case $1 in
    "check") check_auth; hf auth whoami ;;
    "download") download_model "$2" ;;
    "list") list_models ;;
    *) echo "Usage: $0 {check|download|list}" ;;
esac
