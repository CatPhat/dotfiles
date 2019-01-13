#!/usr/bin/env bash
#set -e

source ./setup/common.sh
source ./setup/config.sh

cd $DOTFILES_ROOT

debug "\$DOTFILES_ROOT: ${DOTFILES_ROOT}"
info "Building Dockerfile"
docker build --build-arg dotfiles_root=${DOTFILES_ROOT} -f ${DOTFILES_ROOT}/setup/tests/Dockerfile --tag bats/bats:latest .

info "Running bats-core unit tests"

docker run -it --rm --workdir ${DOTFILES_ROOT} bats/bats:latest -t setup/tests
