#!/usr/bin/env bash
# Helper to install the modular sub-agents.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/common.sh"

info "Bootstrapping agents..."

mkdir -p "$HOME/.config/systemd/user/"
cp "$SCRIPT_DIR/../../systemd/user/"* "$HOME/.config/systemd/user/"

if has systemctl && systemctl --user daemon-reload >/dev/null 2>&1; then
    systemctl --user daemon-reload
    systemctl --user enable --now atlas.timer chronos.timer sentinel.timer forge.timer aegis.timer vault.timer box.timer
    # Oracle is enabled separately as it requires a token
    info "Sub-agents (Atlas, Chronos, Sentinel, Forge, Aegis, Vault, Box) bootstrapped."
    info "To enable remote control, run: systemctl --user enable --now oracle.service"
else
    warn "systemd not detected or not accessible. Agents copied to config but not started."
    info "You can manually start them or use a different supervisor if systemd is unavailable."
fi
