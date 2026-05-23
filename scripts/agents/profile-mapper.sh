#!/bin/bash

# profile-mapper.sh
# Profile Mapper - Records account/profile relationships.

PROFILE_DIR="$(dirname "$0")/../../state/profiles"
mkdir -p "$PROFILE_DIR"

# Simple key-value store for profile mappings
# Usage: ./profile-mapper.sh set <service> <user_profile>
# Usage: ./profile-mapper.sh get <service>

CMD=$1
SERVICE=$2
VALUE=$3

FILE="$PROFILE_DIR/$SERVICE"

if [[ "$CMD" == "set" ]]; then
    echo "$VALUE" > "$FILE"
    echo "Mapped $SERVICE to $VALUE"
elif [[ "$CMD" == "get" ]]; then
    if [[ -f "$FILE" ]]; then
        cat "$FILE"
    else
        echo "unknown"
    fi
fi
