#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    trizen -S --noconfirm polybar-git
}

is_installed() {
   check_if_installed polybar
}

configure() {
    symlink_dotlink "${DOTFILES}/polybar" "$HOME/.config/polybar"
}

is_configured() {
    validate_dotlink "${DOTFILES}/polybar" "$HOME/.config/polybar"
}
