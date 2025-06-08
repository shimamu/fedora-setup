#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Vim"

# Run check-update only once per execution
ensure_check_update_done

# Install vim via dnf
log "Installing vim via dnf"
sudo dnf install -y vim | tee -a "$LOG_FILE"

# Clone vim configuration repo
CONF_REPO_URL="https://github.com/shimamu/vim-config.git"
CONF_REPO_NAME=$(basename "${CONF_REPO_URL%.git}")
CONF_PATH="$CONF_DIR/$CONF_REPO_NAME"

if [ ! -d "$CONF_PATH" ]; then
    log "Cloning vim config to $CONF_PATH"
    git clone "$CONF_REPO_URL" "$CONF_PATH"
else
    log "Config directory already exists: $CONF_PATH"
fi

log "Running setup.sh in $CONF_PATH"
cd "$CONF_PATH" || exit 1
chmod +x setup.sh
./setup.sh | tee -a "$LOG_FILE"

log "Vim installation and setup completed."

