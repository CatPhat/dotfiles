#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm i3-gaps
}

is_installed() {
   check_if_installed i3
}

configure() {
    symlink_dotlink "${DOTFILES}/i3" "$HOME/.config/i3"
}

is_configured() {
    validate_dotlink "${DOTFILES}/i3" "$HOME/.config/i3"
}
