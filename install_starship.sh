#!/bin/bash
source ./common.sh

print_section "Installing starship"

# Run check-update only once per execution
ensure_check_update_done

# Enable the COPR repository for starship
log "Enabling COPR repository: atim/starship"
sudo dnf copr enable -y atim/starship | tee -a "$LOG_FILE"

# Install starship
log "Installing starship"
sudo dnf install -y starship | tee -a "$LOG_FILE"

# Append starship init to .bashrc if not already present
BASHRC="$HOME/.bashrc"
INIT_CMD='eval "$(starship init bash)"'

if ! grep -Fxq "$INIT_CMD" "$BASHRC"; then
    log "Appending starship init command to $BASHRC"
    echo "" >> "$BASHRC"
    echo "$INIT_CMD" >> "$BASHRC"
else
    log "starship init command already present in $BASHRC"
fi

log "starship installation completed."

