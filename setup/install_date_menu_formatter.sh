#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Date Menu Formatter"

# This installation does not require dnf, so we skip check-update
# ensure_check_update_done

# Open GNOME extension page in Firefox
log "Opening Firefox to install GNOME Extension: Date Menu Formatter"
firefox "https://extensions.gnome.org/extension/4655/date-menu-formatter/" &

read -p "After completing the GNOME extension installation in the browser, press [Enter] to continue..."

# Clone and run config setup
CONF_REPO_URL="https://github.com/shimamu/date-menu-formatter-config.git"
CONF_REPO_NAME=$(basename "${CONF_REPO_URL%.git}")
CONF_PATH="$CONF_DIR/$CONF_REPO_NAME"

if [ ! -d "$CONF_PATH" ]; then
    log "Cloning date-menu-formatter config to $CONF_PATH"
    git clone "$CONF_REPO_URL" "$CONF_PATH" | tee -a "$LOG_FILE"
else
    log "Config directory already exists: $CONF_PATH"
fi

log "Running setup.sh in $CONF_PATH"
(cd "$CONF_PATH" && chmod +x setup.sh && ./setup.sh | tee -a "$LOG_FILE")

log "Date Menu Formatter installation and configuration completed."

