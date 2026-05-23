#!/bin/bash

# ai-hub-manager.sh
# Utility to manage centralized local AI models for Ollama and LM Studio.

AI_HUB="$HOME/Projects/.ai-hub"
OLLAMA_MODELS="$AI_HUB/ollama/models"
LM_STUDIO_MODELS="$AI_HUB/lm-studio/models"

setup() {
    echo "[INFO] Setting up centralized AI Hub at $AI_HUB..."
    mkdir -p "$OLLAMA_MODELS" "$LM_STUDIO_MODELS"
    
    # 1. Ollama Configuration
    # We can't easily change the systemd service without sudo, but we can provide a bashrc entry.
    if ! grep -q "OLLAMA_MODELS=" "$HOME/.bashrc"; then
        echo "export OLLAMA_MODELS=\"$OLLAMA_MODELS\"" >> "$HOME/.bashrc"
        echo "[SUCCESS] Added OLLAMA_MODELS to .bashrc. Please restart your terminal or run 'source ~/.bashrc'."
    fi

    # 2. LM Studio Note
    echo "[INFO] For LM Studio: Open Settings > Models > Path and set it to: $LM_STUDIO_MODELS"
}

move_models() {
    # Move existing Ollama models if they exist
    if [[ -d "$HOME/.ollama/models" ]]; then
        echo "[INFO] Moving existing Ollama models to $OLLAMA_MODELS..."
        mv "$HOME/.ollama/models/"* "$OLLAMA_MODELS/" 2>/dev/null || true
        rm -rf "$HOME/.ollama/models"
        ln -s "$OLLAMA_MODELS" "$HOME/.ollama/models"
    fi
}

case $1 in
    "setup") setup ;;
    "move") move_models ;;
    *) echo "Usage: $0 {setup|move}" ;;
esac
