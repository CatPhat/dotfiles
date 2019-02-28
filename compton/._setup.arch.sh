#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    trizen -S --noconfirm compton-git
}

is_installed() {
   check_if_installed compton
}

configure() {
    symlink_dotlink "${DOTFILES}/compton" "$HOME/.config/compton"
}

is_configured() {
    validate_dotlink "${DOTFILES}/compton" "$HOME/.config/compton"
}
