#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing GNOME Tweaks"

ensure_check_update_done

log "Installing gnome-tweaks via dnf"
sudo dnf install -y gnome-tweaks | tee -a "$LOG_FILE"

log "GNOME Tweaks installation completed."
