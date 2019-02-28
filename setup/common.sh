#!/usr/bin/env bash

function __print() {
    echo -e "$1"
}

debug() {
    if $DEBUG; then
    __print "\e[35m\e[1m DEBUG\e[0m -> $1\n"
    fi
}

info() {
	__print "\e[34m\e[1m INFO\e[0m  -> $1\n"
}

user() {
	__print "\e[33m\e[1m USER\e[0m  -> $1\n"
}

success() {
	__print "\e[32m\e[1m OK\e[0m    -> $1\n"
}

fail() {
	__print "\e[31m\e[1m FAIL\e[0m  -> $1\n"
}

check_if_installed() {
    if (command -v $1 > /dev/null); then
        if $DEBUG; then
            success "$1 is installed."
        fi
        return 0
    else
        if $DEBUG; then
            fail "$1 is not installed."
        fi
        return 1
    fi
}

check_if_files_match() {
    if [ ! -e "$1" ]; then
        if $DEBUG; then
            fail "$1 does not exist"
        fi
        return 1
    fi

    if [ ! -e "$2" ]; then
        if $DEBUG; then
            fail "$2 does not exist"
        fi
        return 1
    fi

    local md5sum1=$(md5sum $1 | cut -d' ' -f1)
    local md5sum2=$(md5sum $2 | cut -d' ' -f1)

    if [[ ${md5sum1} == ${md5sum2} ]]; then
        if $DEBUG; then
            success "$1 and $2 match"
        fi
        return 0
    else
        if $DEBUG; then
            fail "$1 and $2 do not match"
        fi
        return 1
    fi
}

# Finds all dotfile setup scripts based on current OS env
# e.g.: OSENV=arch
function find_setup_scripts() {
    while IFS= read -d $'\0' -r file ; do
        echo "$file"
    done < <(find -H ${DOTFILES} -name "*setup.${OSENV}.sh" -not -path '*.git*' -print0)
}