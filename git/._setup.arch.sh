#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm git
}

is_installed() {
   check_if_installed git
}

configure() {
    symlink_dotlink "${DOTFILES}/git" "$HOME"
}

is_configured() {
    validate_dotlink "${DOTFILES}/git" "$HOME"
}
