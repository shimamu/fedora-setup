#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing GNOME Shell Integration for Firefox"

# This tool does not require dnf packages, so we skip check-update
# ensure_check_update_done

# Open Firefox to the GNOME Shell integration extension page
log "Opening Firefox to install GNOME Shell Integration extension"
firefox "https://addons.mozilla.org/ja/firefox/addon/gnome-shell-integration/" &

read -p "After completing the installation in the browser, press [Enter] to continue..."

log "GNOME Shell Integration extension installation completed."

