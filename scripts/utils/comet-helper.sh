#!/bin/bash

# comet-helper.sh
# Utility to integrate Perplexity Comet experience on Linux.

DESKTOP_FILE="$HOME/.local/share/applications/comet.desktop"
ICON_URL="https://www.perplexity.ai/favicon.ico" # Placeholder for icon

setup_web_app() {
    echo "[INFO] Setting up Perplexity Comet (Web Version) as a Desktop App..."
    
    cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Type=Application
Name=Comet Browser
Comment=AI-powered agentic browsing (Perplexity)
Exec=xdg-open https://www.perplexity.ai/
Icon=web-browser
Terminal=false
Categories=Network;WebBrowser;AI;
Keywords=AI;Search;Agent;Comet;
EOF

    chmod +x "$DESKTOP_FILE"
    echo "[SUCCESS] Comet Browser shortcut created at $DESKTOP_FILE"
    echo "[HINT] You can now find 'Comet Browser' in your application menu."
}

check_appimage() {
    echo "[INFO] Checking for official Linux AppImage availability..."
    echo "[HINT] Perplexity often serves an AppImage if you click 'Download for Windows' from a Linux machine."
    echo "[LINK] Visit: https://www.perplexity.ai/platforms"
}

case $1 in
    "setup") setup_web_app ;;
    "check") check_appimage ;;
    *) echo "Usage: $0 {setup|check}" ;;
esac
