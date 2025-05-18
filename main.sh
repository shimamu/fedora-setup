#!/bin/bash
source ./common.sh

# List of scripts to execute (in order)
scripts=(
  ./install_oyainput.sh
  # Add more scripts as needed
)

for script in "${scripts[@]}"; do
  log "Running: $script"
  bash "$script"
done

