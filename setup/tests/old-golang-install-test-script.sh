#!/usr/bin/env bash

source ${DOTFILES}/setup/common.sh
source ${DOTFILES}/setup/symlinks.sh
source ${DOTFILES}/setup/config.sh
source ${DOTFILES}/setup/install.sh

golang_source="${DOTFILES}/golang/._source.zshrc.sh"

install() {
    sudo pacman -S --noconfirm \
        go \
        go-tools
}

is_installed() {
    hello=$(cat <<EOF
package main;
import "fmt";
func main() {
    fmt.Println("Hello, Arch!");
}
EOF
)

    touch /tmp/hello.go
    echo -e ${hello} > /tmp/hello.go
    go run /tmp/hello.go > /dev/null 2>&1
    return $?
}

configure() {
    configure_source "${golang_source}" "${DOTFILES_ZSHRC}"
}

is_configured() {
    validate_source "${golang_source}" "${DOTFILES_ZSHRC}"
}
