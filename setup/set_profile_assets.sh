#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Cloning profile-assets repository and setting user icon"

# Define repository information
ASSETS_REPO_URL="https://github.com/shimamu/profile-assets.git"
ASSETS_REPO_NAME=$(basename "${ASSETS_REPO_URL%.git}")
ASSETS_REPO_PATH="$ASSETS_DIR/$ASSETS_REPO_NAME"

# Check if the repository already exists
if [ -d "$ASSETS_REPO_PATH/.git" ]; then
    log "Repository already cloned: $ASSETS_REPO_PATH"
else
    log "Cloning repository to $ASSETS_REPO_PATH"
    git clone "$ASSETS_REPO_URL" "$ASSETS_REPO_PATH" | tee -a "$LOG_FILE"
fi

log "Repository setup completed: $ASSETS_REPO_PATH"

# Use USERNAME from common.sh
if [ -z "$USERNAME" ]; then
    log "Error: USERNAME is not set in common.sh"
    echo "Error: USERNAME is not set in common.sh"
    exit 1
fi

ICON_SOURCE="$ASSETS_REPO_PATH/icon/icon-dot.svg"
ICON_DEST="/var/lib/AccountsService/icons/$USERNAME"
USER_CONFIG="/var/lib/AccountsService/users/$USERNAME"

log "Setting user icon for $USERNAME"

# Ensure the icon file exists
if [ ! -f "$ICON_SOURCE" ]; then
    log "Error: icon file not found at $ICON_SOURCE"
    echo "Error: icon file not found at $ICON_SOURCE"
    exit 2
fi

# Create destination directories if needed (needs sudo)
sudo mkdir -p "$(dirname "$ICON_DEST")"
sudo mkdir -p "$(dirname "$USER_CONFIG")"
log "Destination directories ensured"

# Copy the icon to the AccountsService directory (needs sudo)
sudo cp "$ICON_SOURCE" "$ICON_DEST"
log "Icon copied to $ICON_DEST"

# Write the user configuration file (needs sudo)
sudo bash -c "cat > '$USER_CONFIG'" <<EOF
[User]
Icon=$ICON_DEST
EOF
log "User config written to $USER_CONFIG"

log "User icon for '$USERNAME' has been updated. Please log out and log back in to see the change."

