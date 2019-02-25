#!/usr/bin/env bash

source $DOTFILES/setup/config.sh

grep -q "GOPATH" ${DOTFILES_ZSHRC} || echo "export GOPATH=${GOPATH}" >> ${DOTFILES_ZSHRC}
grep -q "$GOPATH/bin" ${DOTFILES_ZSHRC} || echo "export PATH="$PATH:$GOPATH/bin"" >> ${DOTFILES_ZSHRC}
