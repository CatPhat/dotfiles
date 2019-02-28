#!/usr/bin/env bash

source "${DOTFILES}/setup/config.sh"
source "${DOTFILES}/setup/common.sh"


function execute_dotfile_setup_scripts() {
    while read file ; do
        info "Executing: ${file}"
        bash ${file} \
            && success "$(dirname ${file}) has been successfully installed." \
            || fail "$(dirname ${file}) failed to install."
    done < <(find_setup_scripts)
}