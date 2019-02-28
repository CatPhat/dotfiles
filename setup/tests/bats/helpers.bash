#!/usr/bin/env bash

BATS_DEBUG=true
FORCE_DEBUG=false

SETUP_SYMLINKS="${DOTFILES_ROOT}/setup/common/symlinks.sh"
SETUP_INSTALL="${DOTFILES_ROOT}/setup/common/install.sh"
SETUP_CONFIG="${DOTFILES_ROOT}/setup/common/config.sh"

debug_print() {
    printf "\e[35m\e[1m BATS-DEBUG\e[0m -> %s\n" "$1" >&3
}

function teardown() {
    # print on failure
    if [[ $result  != true && $BATS_DEBUG == true ]] || [[ $FORCE_DEBUG == true ]]; then
        debug_print "status: ${status}"
        debug_print "result: ${result}"
        if (( "${#lines[@]}" < 2  )); then
            debug_print "output: ${output}"
        else
            debug_print "output: ...omitted, see lines below."
        fi

        for i in "${!lines[@]}"; do
            debug_print "line[$i]: ${lines[$i]}"
        done
    fi
}

assert_equal() {
    local expected=$1
    local actual=$2
    result=false; [[ $actual == $expected ]] && result=true
    if [[ $result != true ]]; then
        debug_print "expected: ${expected}"
        debug_print "actual: ${actual}"
    fi
    [[ $result == true ]]
}
