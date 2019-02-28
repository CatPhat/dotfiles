#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/install.sh
source ${DOTFILES}/setup/symlinks.sh

feh_src="${DOTFILES}/feh/._source.xinitrc.sh"

install() {
    sudo pacman -S --noconfirm feh
}

is_installed() {
   check_if_installed feh
}

configure() {
    configure_source "${feh_src}" "$HOME/.xinitrc"
}

is_configured() {
    validate_source "${feh_src}" "$HOME/.xinitrc"
}
