#!/bin/bash

# mcp-manager.sh
# MCP Manager Agent - Lookup, install, and manage MCP servers.

CONFIG_FILE="$HOME/.config/gemini-cli/mcp.json" # Default for this project
mkdir -p "$(dirname "$CONFIG_FILE")"

# Initialize config if not exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo '{"mcpServers": {}}' > "$CONFIG_FILE"
fi

lookup_mcp() {
    local query=$1
    echo "[INFO] Searching for MCP servers related to '$query' via npm..."
    npm search "mcp-server $query" --json | jq -r '.[] | "\(.name): \(.description)"'
}

install_mcp() {
    local name=$1
    local command=$2
    shift 2
    local args=("$@")

    echo "[INFO] Installing MCP server: $name"
    
    # Convert args array to JSON array
    local args_json=$(printf '%s\n' "${args[@]}" | jq -R . | jq -s . | tr -d '\n')

    # Add to config via jq
    tmp=$(mktemp)
    jq --arg name "$name" --arg cmd "$command" --argjson args "$args_json" \
       '.mcpServers[$name] = {"command": $cmd, "args": $args}' "$CONFIG_FILE" > "$tmp" && mv "$tmp" "$CONFIG_FILE"

    echo "[SUCCESS] MCP server '$name' installed to $CONFIG_FILE"
}

list_mcp() {
    echo "[INFO] Currently installed MCP servers in $CONFIG_FILE:"
    jq -r '.mcpServers | keys[]' "$CONFIG_FILE"
}

case $1 in
    "lookup") lookup_mcp "$2" ;;
    "install") shift; install_mcp "$@" ;;
    "list") list_mcp ;;
    *) echo "Usage: $0 {lookup <query> | install <name> <cmd> [args...] | list}" ;;
esac
