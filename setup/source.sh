#!/usr/bin/env bash

source "${DOTFILES}/setup/config.sh"
source "${DOTFILES}/setup/common.sh"

function get_source_line() {
    local source_file="$1"
    local dst_file="$2"

    echo "source ${source_file}"
}

function configure_source() {
    local source_file="$1"
    local dst_file="$2"
    local source_line
    source_file=$(get_source_line "${source_file}" "${dst_file}")

    if ! validate_source "${source_file}" "${dst_file}"; then
        echo "${source_file}" >> "${dst_file}"
    fi
}

function validate_source() {
    local source_file="$1"
    local dst_file="$2"
    local source_line
    source_file=$(get_source_line "${source_file}" "${dst_file}")

    if grep -q "${source_line}" "${dst_file}"; then
        return 0
    else
        return 1
    fi
}