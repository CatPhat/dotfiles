#!/usr/bin/env bash

source ./setup/common.sh
source ./setup/config.sh

cd $DOTFILES_ROOT

info "Building arch test image."
docker build \
    --tag catphat/dotfiles.arch \
    --build-arg dotfiles_root=${DOTFILES_ROOT} \
    -f ${DOTFILES_ROOT}/setup/tests/arch/Dockerfile \
    .

info "Building bats test image."
docker build \
    --tag catphat/dotfiles.bats \
    --build-arg dotfiles_root=${DOTFILES_ROOT} \
    -f ${DOTFILES_ROOT}/setup/tests/bats/Dockerfile \
    .

info "Running Bats test image."
docker run \
    --rm \
    -e DOTFILES_ROOT=${DOTFILES_ROOT} \
    --workdir ${DOTFILES_ROOT} \
    catphat/dotfiles.bats \
    -t setup/tests
