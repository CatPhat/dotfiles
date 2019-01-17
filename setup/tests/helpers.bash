#!/usr/bin/env bash

BATS_DEBUG=true
FORCE_DEBUG=true

# Root directory of integration tests.
INTEGRATION_ROOT=$(dirname "$(readlink -f "$BASH_SOURCE")")

DOTFILES_REPO_ROOT=${CATPHAT_REPO_ROOT:-$(cd "$INTEGRATION_ROOT/../.."; pwd -P)}

SETUP_SYMLINKS=${SETUP_SYMLINKS:-${DOTFILES_REPO_ROOT}/setup/symlinks.sh}
SETUP_CONFIG=${SETUP_SYMLINKS:-${DOTFILES_REPO_ROOT}/setup/config.sh}

debug_print() {
    printf "\r  [ \033[00;35mBATS-DEBUG\033[0m ] $1\n" >&3
}

function teardown() {
    # print on failure
    if [[ $result  != true && $BATS_DEBUG == true ]] || [[ $FORCE_DEBUG == true ]]; then
        debug_print "status: ${status}"
        debug_print "result: ${result}"
        if (( ${#lines[@]} < 2  )); then
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
    local actual=$1
    local expected=$2
    result=false; [[ $actual == $expected ]] && result=true
    if [[ $result != true ]]; then
        debug_print "expected: ${expected}"
        debug_print "actual: ${actual}"
    fi
    [[ $result == true ]]
}
