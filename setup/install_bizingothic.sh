#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Installing Bizin Gothic NF font"

ensure_check_update_done

# Font download URL and version
FONT_URL="https://github.com/yuru7/bizin-gothic/releases/download/v0.0.4/BizinGothicNF_v0.0.4.zip"
FONT_ZIP_NAME=$(basename "$FONT_URL")
FONT_VERSION_DIR="BizinGothicNF_v0.0.4"
TMP_ZIP_PATH="/tmp/$FONT_ZIP_NAME"
UNZIP_DIR="/tmp/$FONT_VERSION_DIR"
INSTALL_DIR="$HOME/.local/share/fonts/$FONT_VERSION_DIR"
FONT_NAME="Bizin Gothic NF"

# Install unzip if not present
if ! command -v unzip &> /dev/null; then
    log "Installing unzip"
    sudo dnf install -y unzip | tee -a "$LOG_FILE"
fi

# Download font zip
log "Downloading font from $FONT_URL"
curl -L -o "$TMP_ZIP_PATH" "$FONT_URL" | tee -a "$LOG_FILE"

# Extract
log "Extracting $TMP_ZIP_PATH to $UNZIP_DIR"
rm -rf "$UNZIP_DIR"
mkdir -p "$UNZIP_DIR"
unzip -o "$TMP_ZIP_PATH" -d "$UNZIP_DIR" | tee -a "$LOG_FILE"

# Move extracted folder to ~/.local/share/fonts/
log "Installing fonts to $INSTALL_DIR"
mkdir -p "$(dirname "$INSTALL_DIR")"
rm -rf "$INSTALL_DIR"
mv "$UNZIP_DIR" "$INSTALL_DIR"

# Refresh font cache
log "Refreshing font cache"
fc-cache -fv | tee -a "$LOG_FILE"

# Set GNOME Ptyxis font
if command -v gsettings &> /dev/null; then
    log "Disabling system font for org.gnome.Ptyxis"
    gsettings set org.gnome.Ptyxis use-system-font false

    log "Setting org.gnome.Ptyxis.font-name to \"$FONT_NAME 12\""
    gsettings set org.gnome.Ptyxis font-name "$FONT_NAME 12"
else
    log "gsettings command not found. Skipping GNOME Ptyxis font configuration."
fi

log "Bizin Gothic NF font installation completed."

