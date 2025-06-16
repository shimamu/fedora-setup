#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing rpm-build"

# Run check-update only once per execution
ensure_check_update_done

log "Installing rpm-build via dnf"
sudo dnf install -y rpm-build | tee -a "$LOG_FILE"

log "rpm-build installation completed."

