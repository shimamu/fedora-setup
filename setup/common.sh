#!/bin/bash

# Always resolve absolute path to the original current directory
ORIGINAL_PWD="$(pwd)"
LOG_FILE="$ORIGINAL_PWD/install.log"
TMP_FLAG="/tmp/post_install_check_update_done"
CONF_DIR="$HOME/conf"
BUILD_DIR="$HOME/build"
ASSETS_DIR="$HOME/assets"
# Set USERNAME if not already set in environment variables
# USERNAME=

# Logging with timestamp: color in terminal, no color in log file
log() {
    local ts msg
    ts=$(date '+%Y-%m-%d %H:%M:%S')
    msg="[$ts] $*"

    # Blue for terminal
    local COLOR='\033[0;36m' # Cyan
    local NC='\033[0m'       # No Color (reset)
    echo -e "${COLOR}[$ts] $*${NC}"

    # Plain text for log file
    echo "$msg" >> "$LOG_FILE"
}

# Ensure necessary directories exist
init_common_dirs() {
    for dir in "$CONF_DIR" "$BUILD_DIR" "$ASSETS_DIR"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            log "Created directory: $dir"
        else
            log "Directory already exists: $dir"
        fi
    done
}

# Section header
print_section() {
    log "=============================="
    log "$1"
    log "=============================="
}

# Ensure 'dnf check-update' is run only once per script execution
ensure_check_update_done() {
    if [ ! -f "$TMP_FLAG" ]; then
        print_section "Running system check-update"
        sudo dnf check-update | tee -a "$LOG_FILE"
        touch "$TMP_FLAG"
        log "System check-update completed."
    else
        log "System check-update already performed during this run. Skipping."
    fi
}

# Cleanup function
cleanup_check_update_flag() {
    if [ -f "$TMP_FLAG" ]; then
        rm -f "$TMP_FLAG"
        log "Temporary check-update flag has been removed."
    fi
}
# Trap for cleaning up the check update flag, only if NOT running from main.sh
if [ -z "$RUNNING_FROM_MAIN" ]; then
    trap cleanup_check_update_flag EXIT
fi

# Initialize required directories immediately
init_common_dirs

