#!/usr/bin/env bash

#TODO:  automate nvim plugin setup post-install.
#       needs to be handled after dotfile nvim init.vim
#       has been symlinked via setup/symlinks.sh
#       eg:  nvim -v +PluginInstall +qall
sudo pacman -S --noconfirm neovim python-neovim
