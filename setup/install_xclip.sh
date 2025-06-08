#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing xclip"

# Run check-update only once per execution
ensure_check_update_done

log "Installing xclip via dnf"
sudo dnf install -y xclip | tee -a "$LOG_FILE"

log "xclip installation completed."

