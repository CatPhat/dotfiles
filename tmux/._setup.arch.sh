#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S --noconfirm tmux
}

configure() {
    symlink_dotlink "${DOTFILES}/tmux" "$HOME/.config/tmux"
}

is_installed() {
   check_if_installed tmux
}

is_configured() {
    validate_dotlink "${DOTFILES}/tmux" "$HOME/.config/tmux"
}
