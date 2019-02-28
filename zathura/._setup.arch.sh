#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm zathura
}

is_installed() {
   check_if_installed zathura
}

configure() {
    symlink_dotlink "${DOTFILES}/zathura" "$HOME/.config/zathura"
}

is_configured() {
    symlink_dotlink "${DOTFILES}/zathura" "$HOME/.config/zathura"
}