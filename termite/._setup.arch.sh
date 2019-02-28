#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm termite termite-terminfo
}

is_installed() {
   check_if_installed termite
}

configure() {
    symlink_dotlink "${DOTFILES}/termite" "$HOME/.config/termite"
}

is_configured() {
    validate_dotlink "${DOTFILES}/termite" "$HOME/.config/termite"
}
