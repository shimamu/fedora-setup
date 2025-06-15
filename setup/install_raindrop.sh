#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Raindrop.io (Firefox Add-on)"

# This installation does not require dnf, so we skip check-update
# ensure_check_update_done

# Open Raindrop.io Firefox Add-on page
log "Opening Firefox to install Raindrop.io Firefox Add-on"
firefox "https://addons.mozilla.org/ja/firefox/addon/raindropio/" &

read -p "After completing the Raindrop.io Add-on installation in the browser, press [Enter] to continue..."

log "Raindrop.io installation (Firefox Add-on) step completed."

