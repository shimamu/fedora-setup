#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing oyainput-fix build dependencies"

# Run check-update only once per execution
ensure_check_update_done

log "Installing gcc-c++ and fcitx5-devel via dnf"
sudo dnf install -y gcc-c++ fcitx5-devel | tee -a "$LOG_FILE"

log "oyainput-fix build dependencies installation completed."

