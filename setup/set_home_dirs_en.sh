#!/bin/bash
source "$(dirname "$0")/common.sh"

print_section "Converting home directory names to English"

# No dnf packages used, so update check is not needed
# ensure_check_update_done

# List of known Japanese-named XDG user directories
JAPANESE_DIRS=("ダウンロード" "デスクトップ" "ドキュメント" "ピクチャ" "ビデオ" "ミュージック" "テンプレート" "パブリック")

NEED_CONVERT=false

# Check if any Japanese-named directory exists in $HOME
for dir in "${JAPANESE_DIRS[@]}"; do
    if [ -d "$HOME/$dir" ]; then
        log "Detected Japanese-named directory: $dir"
        NEED_CONVERT=true
        break
    fi
done

if $NEED_CONVERT; then
    log "Launching xdg-user-dirs-gtk-update with LANG=C"
    LANG=C xdg-user-dirs-gtk-update
    log "Please follow the dialog to convert directory names to English."
else
    log "No Japanese-named directories found. Skipping conversion."
fi

log "Home directory conversion check completed."

