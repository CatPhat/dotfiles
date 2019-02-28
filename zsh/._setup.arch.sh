#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh
source ${DOTFILES}/setup/install.sh

dotfiles_zsh="${DOTFILES}/zsh"
zsh_source="${dotfiles_zsh}/._source.zshrc.sh"

install() {
    sudo pacman -S --noconfirm zsh
}

is_installed() {
   check_if_installed zsh
}

configure() {
    symlink_dotlink "${DOTFILES}/zsh" "${HOME}"
    configure_source "${zsh_source}" "${DOTFILES_ZSHRC}"
}

is_configured() {
    validate_dotlink "${DOTFILES}/zsh" "${HOME}"
    validate_source "${zsh_source}" "${DOTFILES_ZSHRC}"
}
