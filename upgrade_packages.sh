#!/bin/bash
source ./common.sh

print_section "Upgrading system packages"

# Skip check-update here because 'dnf upgrade' already performs update check
# ensure_check_update_done

# Upgrade packages
log "Running: sudo dnf upgrade -y"
sudo dnf upgrade -y | tee -a "$LOG_FILE"

log "System package upgrade completed."

