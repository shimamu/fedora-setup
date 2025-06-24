#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing wl-clipboard (wl-copy and wl-paste)"

# Run dnf check-update once per execution
ensure_check_update_done

log "Installing wl-clipboard package via dnf"
sudo dnf install -y wl-clipboard | tee -a "$LOG_FILE"

log "wl-clipboard installation completed."

