#!/usr/bin/env bash

source "${DOTFILES}/setup/config.sh"
source "${DOTFILES}/setup/common.sh"

setup() {
    local dotfile=$1
    local dotfile_dir="${DOTFILES}/${dotfile}"
    local dotfile_setup="${dotfile_dir}/._setup.${OSENV}.sh"

    source "${dotfile_setup}"

    info "Setting up ${dotfile}"
    if ! is_installed; then 
       info "Installing $dotfile_setup"
       install 
    else
        info "${dotfile} already installed."
    fi

    if ! is_configured; then
        info "Configuring ${dotfile}"
       configure 
    else
        info "${dotfile} already configured."
    fi

    info "Done setting up ${dotfile}"
}