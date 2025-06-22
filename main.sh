#!/bin/bash
source ./setup/common.sh
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
    log "Running: ./setup/upgrade_packages.sh"
    bash ./setup/upgrade_packages.sh
fi

# List of setup scripts to execute (in order)
scripts=(
    set_home_dirs_en.sh
    set_profile_assets.sh
    install_xclip.sh
    install_bitwarden.sh
    install_raindrop.sh
    install_gnome_tweaks.sh
    install_gnome_shell_integration.sh
    install_dash_to_panel.sh
    install_date_menu_formatter.sh
    install_reorder_workspaces.sh
    install_fcitx5.sh
    install_oyainput.sh
    install_oyainput_build_deps.sh
    install_starship.sh
    install_vim.sh
    install_rpmbuild.sh
    install_bizingothic.sh
    # Add more scripts as needed
)

for script in "${scripts[@]}"; do
    log "Running: ./setup/$script"
    bash "./setup/$script"
done

