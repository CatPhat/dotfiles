#!/usr/bin/env bash

source "${DOTFILES}/setup/config.sh"
source "${DOTFILES}/setup/common.sh"

function dotfile_setup_status() {
    local setup_script=$1
    source ${setup_script}

    local install_status
    is_installed
    install_status=$(get_exit_status_as_symbol $?)


    local config_status
    is_configured
    config_status=$(get_exit_status_as_symbol $?)

    local parent_dir=$(dirname ${setup_script})
    echo -e "${install_status} ${config_status}  : ${parent_dir##*/}"
}

function get_exit_status_as_symbol() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m\e[1m ✓\e[0m"
    elif [ $1 -eq 77 ]; then
        # No install/configuration done
        echo -e "\e[33m\e[1m •\e[0m"
    else
        echo -e "\e[31m\e[1m ✕\e[0m"
    fi
}

function get_dotfile_setup_status() {
    info "Status of dotfiles (installed, configured : dotfile)"
    while read file ; do
        dotfile_setup_status ${file}
    done < <(find_setup_scripts)
}

