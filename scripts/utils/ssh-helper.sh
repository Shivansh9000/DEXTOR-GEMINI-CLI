#!/bin/bash

# ssh-helper.sh
# Utility to manage VPS connections and SSH key setup.

# 1. Setup SSH Key on VPS
# Usage: ./ssh-helper.sh setup <user> <vps_ip>
setup_ssh() {
    local user=$1
    local ip=$2
    if [[ -z "$user" || -z "$ip" ]]; then
        echo "[ERROR] Usage: setup <user> <vps_ip>"
        exit 1
    fi
    echo "[INFO] Copying SSH key to $user@$ip..."
    ssh-copy-id -i ~/.ssh/id_rsa.pub "$user@$ip"
}

# 2. Test Connection
# Usage: ./ssh-helper.sh test <user> <vps_ip>
test_ssh() {
    local user=$1
    local ip=$2
    if ssh -q -o BatchMode=yes -o ConnectTimeout=5 "$user@$ip" exit; then
        echo "[SUCCESS] SSH connection to $user@$ip is active."
    else
        echo "[ERROR] Could not connect to $user@$ip."
        exit 1
    fi
}

# 3. Add to SSH Config
# Usage: ./ssh-helper.sh alias <name> <user> <vps_ip>
add_alias() {
    local name=$1
    local user=$2
    local ip=$3
    echo -e "\nHost $name\n    HostName $ip\n    User $user" >> ~/.ssh/config
    echo "[SUCCESS] Added alias '$name' to ~/.ssh/config. You can now use: ssh $name"
}

case $1 in
    "setup") setup_ssh "$2" "$3" ;;
    "test") test_ssh "$2" "$3" ;;
    "alias") add_alias "$2" "$3" "$4" ;;
    *) echo "Usage: $0 {setup|test|alias}" ;;
esac
