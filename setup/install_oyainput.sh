#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing oyainput"

# Run check-update only once per execution
ensure_check_update_done

# Install required build tools
log "Installing build tools (gcc, make, git)"
sudo dnf install -y gcc make git | tee -a "$LOG_FILE"

# Repositories with .git suffix
BUILD_REPO_URL="https://github.com/shimamu/oyainput-fcitx5-fix.git"
CONF_REPO_URL="https://github.com/shimamu/oyainput-config.git"

# Extract repo names from URLs (remove .git)
BUILD_REPO_NAME=$(basename "${BUILD_REPO_URL%.git}")
CONF_REPO_NAME=$(basename "${CONF_REPO_URL%.git}")

# Derived paths
BUILD_PATH="$BUILD_DIR/$BUILD_REPO_NAME"
CONF_PATH="$CONF_DIR/$CONF_REPO_NAME"

# Clone and build
if [ ! -d "$BUILD_PATH" ]; then
    log "Cloning oyainput source to $BUILD_PATH"
    git clone "$BUILD_REPO_URL" "$BUILD_PATH"
else
    log "Build directory already exists: $BUILD_PATH"
fi

log "Building oyainput"
cd "$BUILD_PATH" || exit 1
make | tee -a "$LOG_FILE"
sudo make install | tee -a "$LOG_FILE"

# Clone and run config setup
if [ ! -d "$CONF_PATH" ]; then
    log "Cloning oyainput config to $CONF_PATH"
    git clone "$CONF_REPO_URL" "$CONF_PATH"
else
    log "Config directory already exists: $CONF_PATH"
fi

log "Running setup.sh in $CONF_PATH"
cd "$CONF_PATH" || exit 1
chmod +x setup.sh
./setup.sh | tee -a "$LOG_FILE"

log "oyainput installation completed."

