#!/bin/bash

# Simple script to translate technical events into plain English.
# Usage: ./plain-english-narrator.sh <component> <status_or_error>

COMPONENT=$1
STATUS=$2

case $COMPONENT in
    "sentinel")
        if [[ "$STATUS" == "docker_down" ]]; then
            echo "The 'Docker' app (which runs your project's tools) is currently sleeping. You might need to start it up before you can work."
        elif [[ "$STATUS" == "path_issue" ]]; then
            echo "A small piece of the computer's map is missing. This might make it hard for the tools to find each other."
        elif [[ "$STATUS" == "devcontainer_missing" ]]; then
            echo "The 'Dev Container' tool is missing. It's needed for specialized development environments."
        else
            echo "Sentinel noticed something unusual with the project's background tools."
        fi
        ;;
    "forge")
        if [[ "$STATUS" == "git_auth_fail" ]]; then
            echo "Your GitHub keys aren't working right now. It's like the project's front door is locked."
        elif [[ "$STATUS" == "conflict" ]]; then
            echo "There's a disagreement between your work and the saved version. We need to decide which one to keep."
        else
            echo "Forge is watching over your saved work and noticed a small hiccup."
        fi
        ;;
    "aegis")
        if [[ "$STATUS" == "cloudflare_offline" ]]; then
            echo "Cloudflare (the project's security guard) is currently away from its post."
        else
            echo "Aegis is checking the project's internet security and found something to look at."
        fi
        ;;
    "atlas")
        if [[ "$STATUS" == "missing_docker" ]]; then
            echo "Atlas noticed the 'Docker' toolbox is missing. We might need to install it again."
        elif [[ "$STATUS" == "missing_github_cli" ]]; then
            echo "Atlas can't find the 'GitHub' tool. It's like we lost the key to the save box."
        else
            echo "Atlas is checking our tools and found something missing: $STATUS"
        fi
        ;;
    "vault")
        if [[ "$STATUS" == "session_locked" ]]; then
            echo "Your 1Password vault is currently locked. I can't reach your secret keys until you unlock it."
        else
            echo "Vault Guard noticed something with your 1Password setup."
        fi
        ;;
    "box")
        if [[ "$STATUS" == "backup_manual_step_required" ]]; then
            echo "I've prepared a backup of your project's DNA, but I need you to sign in to Box or provide a folder ID to finish the save."
        elif [[ "$STATUS" == "cli_missing" ]]; then
            echo "I can't find the 'Box' tool. We need to install it to keep your project's backup safe."
        else
            echo "Box Guard is looking after your project's backup and noticed something."
        fi
        ;;
    *)
        echo "Something happened in the project that we should check on: $STATUS"
        ;;
esac
