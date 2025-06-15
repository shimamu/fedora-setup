#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Bitwarden (Firefox Add-on)"

# This installation does not require dnf, so we skip check-update
# ensure_check_update_done

# Open Bitwarden Firefox Add-on page
log "Opening Firefox to install Bitwarden Firefox Add-on"
firefox "https://addons.mozilla.org/ja/firefox/addon/bitwarden-password-manager/" &

read -p "After completing the Bitwarden Add-on installation in the browser, press [Enter] to continue..."

log "Bitwarden installation (Firefox Add-on) step completed."

