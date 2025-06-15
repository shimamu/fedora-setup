#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing oyainput"

# Run check-update only once per execution
ensure_check_update_done

# Install oyainput via COPR repository
log "Enabling COPR repository for oyainput-fix"
sudo dnf copr enable -y shimamu/oyainput-fix | tee -a "$LOG_FILE"

log "Installing oyainput-fix via dnf"
sudo dnf install -y oyainput-fix | tee -a "$LOG_FILE"

# Open GNOME extension page in Firefox
log "Opening Firefox to install GNOME Extension: oyainput-indicator"
firefox "https://extensions.gnome.org/extension/8248/oyainput-indicator/" &

read -p "After completing the GNOME extension installation in the browser, press [Enter] to continue..."

# Clone and run config setup
CONF_REPO_URL="https://github.com/shimamu/oyainput-config.git"
CONF_REPO_NAME=$(basename "${CONF_REPO_URL%.git}")
CONF_PATH="$CONF_DIR/$CONF_REPO_NAME"

if [ ! -d "$CONF_PATH" ]; then
    log "Cloning oyainput config to $CONF_PATH"
    git clone "$CONF_REPO_URL" "$CONF_PATH" | tee -a "$LOG_FILE"
else
    log "Config directory already exists: $CONF_PATH"
fi

log "Running setup.sh in $CONF_PATH"
(cd "$CONF_PATH" && chmod +x setup.sh && ./setup.sh | tee -a "$LOG_FILE")

log "oyainput installation and configuration completed."

