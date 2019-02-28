#!/usr/bin/env bash

DOTFILES=$(pwd -P)
source "${DOTFILES}/setup/common.sh"
source "${DOTFILES}/setup/config.sh"

info "Building arch test image."
docker build \
    --tag catphat/dotfiles.arch \
    --build-arg dotfiles_root=${DOTFILES} \
    --build-arg host_user=${USER} \
    -f ${DOTFILES}/setup/tests/arch/Dockerfile \
    .

if [[ $? == 0 ]]; then
    success "Successfully built catphat/dotfiles.arch docker image."
    info "Running arch test image."
    docker run \
           --rm \
           -e DOTFILES_ROOT=${DOTFILES} \
           -e host_user=${USER} \
           --workdir ${DOTFILES} \
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
