#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing fcitx5 and configuring input method"

ensure_check_update_done

log "Installing fcitx5 packages via dnf"
sudo dnf install -y fcitx5-mozc fcitx5-autostart fcitx5-qt fcitx5-gtk fcitx5-configtool | tee -a "$LOG_FILE"

log "Configuring input method alternatives"
sudo alternatives --config xinputrc

log "Opening Firefox to install GNOME Extension: Input Method Panel (kimpanel)"
firefox "https://extensions.gnome.org/extension/261/kimpanel/" &

read -p "After completing the Input Method Panel extension installation in the browser, press [Enter] to continue..."

# Clone fcitx5 config and run setup
REPO_URL="https://github.com/shimamu/fcitx5-config"
TARGET_DIR="$CONF_DIR/fcitx5-config"

log "Cloning fcitx5-config repository: $REPO_URL"
git clone "$REPO_URL" "$TARGET_DIR" | tee -a "$LOG_FILE"

log "Running setup.sh in $TARGET_DIR"
(cd "$TARGET_DIR" && bash ./setup.sh | tee -a "$LOG_FILE")

log "fcitx5 installation and configuration completed."

