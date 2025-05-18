#!/bin/bash
source ./common.sh

print_section "Installing Vim"

# Run check-update only once per execution
ensure_check_update_done

# Install vim via dnf
log "Installing vim via dnf"
sudo dnf install -y vim | tee -a "$LOG_FILE"

# Clone Vundle plugin manager
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
if [ ! -d "$VUNDLE_DIR" ]; then
    log "Cloning Vundle to $VUNDLE_DIR"
    git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
else
    log "Vundle already exists at: $VUNDLE_DIR"
fi

# Clone vim configuration repo
CONF_REPO_URL="https://github.com/shimamu/vim-dotfiles.git"
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

# Clone vim colors repo
COLORS_REPO_URL="https://github.com/shimamu/vim-colors.git"
COLORS_REPO_NAME=$(basename "${COLORS_REPO_URL%.git}")
COLORS_PATH="$CONF_DIR/$COLORS_REPO_NAME"

if [ ! -d "$COLORS_PATH" ]; then
    log "Cloning vim colors to $COLORS_PATH"
    git clone "$COLORS_REPO_URL" "$COLORS_PATH"
else
    log "Colors directory already exists: $COLORS_PATH"
fi

log "Running setup.sh in $COLORS_PATH"
cd "$COLORS_PATH" || exit 1
chmod +x setup.sh
./setup.sh | tee -a "$LOG_FILE"

log "Vim installation and setup completed."

