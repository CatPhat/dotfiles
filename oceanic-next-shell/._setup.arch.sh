#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/install.sh
source ${DOTFILES}/setup/config.sh

oceanic_path="${DOTFILES}/oceanic-next-shell/git-repo"
oceanic_source="${DOTFILES}/oceanic-next-shell/._source.zshrc.sh"

install() {
    mkdir -p "${oceanic_path}"
    git clone https://github.com/mhartington/oceanic-next-shell.git "${oceanic_path}"
}

is_installed() {
    [[ -e ${oceanic_path} ]]
}

configure() {
    configure_source "${oceanic_source}" "${DOTFILES_ZSHRC}"

}

is_configured() {
    validate_source "${oceanic_source}" "${DOTFILES_ZSHRC}"
}
