#!/bin/bash
source ./common.sh
export RUNNING_FROM_MAIN=1

# List of scripts to execute (in order)
scripts=(
    ./install_fcitx5.sh
    ./install_oyainput.sh
    ./install_vim.sh
    # Add more scripts as needed
)

for script in "${scripts[@]}"; do
    log "Running: $script"
    bash "$script"
done

