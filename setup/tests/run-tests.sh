#!/usr/bin/env bash

DOTFILES=$(pwd -P)
source ./setup/common.sh
source ./setup/config.sh

cd $DOTFILES_ROOT

info "Building arch test image."
docker build \
    --tag catphat/dotfiles.arch \
    --build-arg dotfiles_root=${DOTFILES_ROOT} \
    --build-arg host_user=${USER} \
    -f ${DOTFILES_ROOT}/setup/tests/arch/Dockerfile \
    .

if [[ $? == 0 ]]; then
    success "Successfully built catphat/dotfiles.arch docker image."
    info "Running arch test image."
    docker run \
           --rm \
           -e DOTFILES_ROOT=${DOTFILES_ROOT} \
           -e host_user=${USER} \
           --workdir ${DOTFILES_ROOT} \
           --interactive --tty \
           catphat/dotfiles.arch \
           -t setup/tests/bats
else
    fail "Could not build catphat/dotfiles.arch docker image."
fi

#info "Building bats test image."
#docker build \
#    --tag catphat/dotfiles.bats \
#    --build-arg dotfiles_root=${DOTFILES_ROOT} \
#    -f ${DOTFILES_ROOT}/setup/tests/bats/Dockerfile \
#    .

#info "Running Bats test image."
#docker run \
#    --rm \
#    -e DOTFILES_ROOT=${DOTFILES_ROOT} \
#    --workdir ${DOTFILES_ROOT} \
#    catphat/dotfiles.bats \
#    -t setup/tests/bats
