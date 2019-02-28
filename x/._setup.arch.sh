#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    sudo pacman -S xorg-xinit
}

is_installed() {
    pacman -Q xorg-xinit
}

configure() {
    stow -t "$HOME" -d "${DOTFILES}/x/${HWENV}" 
}

is_configured() {
    validate_dotlink "${DOTFILES}/x/${HWENV}" "$HOME"
}
