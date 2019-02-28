#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm gtk3
}

is_installed() {
   check_if_installed gtk3-demo
}

configure() {
    symlink_dotlink "${DOTFILES}/gtk-3.0" "$HOME/.config/gtk-3.0"
}

is_configured() {
    validate_dotlink "${DOTFILES}/gtk-3.0" "$HOME/.config/gtk-3.0"
}
