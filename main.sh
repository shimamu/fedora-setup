#!/bin/bash
source ./common.sh
export RUNNING_FROM_MAIN=1

# Check for --no-upgrade option
DO_UPGRADE=1
for arg in "$@"; do
    if [ "$arg" == "--no-upgrade" ]; then
        DO_UPGRADE=0
        break
    fi
done

# Optionally upgrade packages first
if [ "$DO_UPGRADE" -eq 1 ]; then
    log "Running: ./upgrade_packages.sh"
    bash ./upgrade_packages.sh
fi

# List of scripts to execute (in order)
scripts=(
    ./set_home_dirs_en.sh
    ./install_fcitx5.sh
    ./install_oyainput.sh
    ./install_bizingothic.sh
    ./install_starship.sh
    ./install_vim.sh
    # Add more scripts as needed
)

for script in "${scripts[@]}"; do
    log "Running: $script"
    bash "$script"
done

