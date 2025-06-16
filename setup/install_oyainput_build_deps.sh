#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing oyainput-fix-rpm build dependencies"

# Run check-update only once per execution
ensure_check_update_done

log "Installing gcc-c++ via dnf"
sudo dnf install -y gcc-c++ | tee -a "$LOG_FILE"

log "oyainput-fix-rpm build dependencies installation completed."

