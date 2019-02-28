#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh

install() {
    trizen -S antibody-bin --noconfirm
}

configure() {
    antibody bundle < ${DOTFILES}/antibody/bundles.txt > ${DOTFILES}/antibody/zsh_plugins.sh
    cat ${DOTFILES}/antibody/zsh_plugins.sh > ~/.zsh_plugins.sh
    antibody update
}

is_installed() {
   check_if_installed antibody
}

is_configured() {
    check_if_files_match "${DOTFILES}/antibody/zsh_plugins.sh" "${HOME}/.zsh_plugins.sh"
}
