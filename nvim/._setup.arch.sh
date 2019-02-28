#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh

install() {
    #TODO:  automate nvim plugin setup post-install.
    #       needs to be handled after dotfile nvim init.vim
    #       has been symlinked via setup/symlinks.sh
    #       eg:  nvim -v +PluginInstall +qall
    sudo pacman -S --noconfirm neovim python-neovim
}

is_installed() {
   check_if_installed nvim
}

configure() {
    symlink_dotlink "${DOTFILES}/nvim" "$HOME/.config/nvim"
}

is_configured() {
    validate_dotlink "${DOTFILES}/nvim" "$HOME/.config/nvim"
}
