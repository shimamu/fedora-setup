#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Reorder Workspaces"

# This installation does not require dnf, so we skip check-update$
# ensure_check_update_done$

# Open GNOME extension page in Firefox
EXTENSION_URL="https://extensions.gnome.org/extension/3685/reorder-workspaces/"
log "Opening Firefox to install GNOME Extension: Reorder Workspaces"
firefox "$EXTENSION_URL" &

read -p "After completing the GNOME extension installation in the browser, press [Enter] to continue..."

log "Reorder Workspaces installation step completed."

