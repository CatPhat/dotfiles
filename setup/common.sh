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
