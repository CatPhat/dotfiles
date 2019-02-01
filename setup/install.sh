#!/usr/bin/env bash

source "${DOTFILES_ROOT}/setup/config.sh"
source "${DOTFILES_ROOT}/setup/common.sh"

# Finds all dotfile install scripts based on current OS env
# e.g.: OSENV=arch
function find_install_scripts() {
    while IFS= read -d $'\0' -r file ; do
        echo "$file"
    done < <(find -H ${DOTFILES_ROOT} -name "*install.${OSENV}.sh" -not -path '*.git*' -print0)
}

function execute_dotfile_install_scripts() {
    while read file ; do
        info "Executing: ${file}"
        bash ${file} \
            && success "$(dirname ${file}) has been successfully installed." \
            || fail "$(dirname ${file}) failed to install."
    done < <(find_install_scripts)
}

function execute_dotfile_setup_prequisite_scripts() {
    bash ${DOTFILES_ROOT}/setup/setup_prequisites.${OSENV}.sh \
            && success "Successfully installed setup prequisites for OSENV: ${OSENV}" \
            || fail "Could not install setup prequisites for OSENV: ${OSENV}" \

}
