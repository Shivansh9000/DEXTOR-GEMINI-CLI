#!/usr/bin/env bash
# Hostinger VPS Utility Helper

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

export HAPI_API_TOKEN="${HAPI_API_TOKEN:-XS3ufqeWU8ABLbPFXm96zZlNvbyhLpY7mDFOpfsac0e91a20}"

usage() {
    cat <<EOF
Usage: ./hostinger-helper.sh [command]
Commands:
  list        List all VPS instances
  status <id> Get status of a specific VPS
  start <id>  Start a VPS
  stop <id>   Stop a VPS
  ssh         SSH into the primary VPS (194.164.149.18)
  setup-ssh   Push local SSH key to the VPS
EOF
}

case "${1:-}" in
    list)
        hapi vps vm list
        ;;
    status)
        if [[ -z "${2:-}" ]]; then error "Missing VPS ID"; fi
        hapi vps vm get "$2"
        ;;
    start)
        if [[ -z "${2:-}" ]]; then error "Missing VPS ID"; fi
        hapi vps vm start "$2"
        ;;
    stop)
        if [[ -z "${2:-}" ]]; then error "Missing VPS ID"; fi
        hapi vps vm stop "$2"
        ;;
    ssh)
        ssh root@194.164.149.18
        ;;
    setup-ssh)
        info "Pushing SSH key to root@194.164.149.18"
        ssh-copy-id -i ~/.ssh/id_ed25519.pub root@194.164.149.18
        ;;
    *)
        usage
        ;;
esac
