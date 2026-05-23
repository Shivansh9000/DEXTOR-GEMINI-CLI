#!/bin/bash

# box-backup.sh
# Box Guard - Packages and uploads project setup, config, and documentation to Box.

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
BACKUP_DIR="$HOME/.local/share/ai-dev-setup/backups"
NOTIFY_WRAPPER="$PROJECT_ROOT/scripts/utils/notify-wrapper.sh"
STAGING_DIR="/tmp/ai-dev-box-backup"

# 1. Prepare staging area
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

echo "[INFO] Staging files for Box backup..."

# Copy .md files from root and docs/
find "$PROJECT_ROOT" -maxdepth 1 -name "*.md" -exec cp {} "$STAGING_DIR" \;
mkdir -p "$STAGING_DIR/docs"
cp -r "$PROJECT_ROOT/docs/"* "$STAGING_DIR/docs/" 2>/dev/null || true

# Copy scripts and configs
mkdir -p "$STAGING_DIR/scripts"
cp -r "$PROJECT_ROOT/scripts/"* "$STAGING_DIR/scripts/" 2>/dev/null || true

mkdir -p "$STAGING_DIR/main-config"
cp -r "$PROJECT_ROOT/main-config/"* "$STAGING_DIR/main-config/" 2>/dev/null || true

mkdir -p "$STAGING_DIR/systemd"
cp -r "$PROJECT_ROOT/systemd/"* "$STAGING_DIR/systemd/" 2>/dev/null || true

# 2. Package
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="ai-dev-env-backup-$TIMESTAMP.tar.gz"
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$STAGING_DIR" .

echo "[INFO] Backup package created: $BACKUP_FILE"

# 3. Upload to Box
# Note: This requires 'box login' or a valid developer token.
if command -v box &> /dev/null; then
    echo "[INFO] Attempting to upload to Box..."
    # Placeholder for actual box upload command
    # box files:upload "$BACKUP_DIR/$BACKUP_FILE" --parent-id "YOUR_BOX_FOLDER_ID"
    echo "[WARN] Box upload requires 'box login' and a destination Folder ID."
    bash "$NOTIFY_WRAPPER" "box" "backup_manual_step_required"
else
    bash "$NOTIFY_WRAPPER" "box" "cli_missing"
fi

# 4. Cleanup
rm -rf "$STAGING_DIR"
