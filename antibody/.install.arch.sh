#!/usr/bin/env bash

trizen -S antibody-bin --noconfirm
antibody bundle < ${DOTFILES}/antibody/bundles.txt > ~/.zsh_plugins.sh
antibody update
