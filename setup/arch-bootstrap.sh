#!/bin/sh
set -x
set -o
set -e

sudo pacman --noconfirm -S reflector
#sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman --noconfirm -S python2 libyaml python2-yaml fabric lsb-release

#should be handled via yaml config
sudo pacman --noconfirm -S binutils make gcc pkg-config fakeroot cmake

#slow downloads/compiles temporarily putting here to cache in docker build
sudo pacman --noconfirm -S git xorg-server xorg-xinit
#mkdir ~/dotfiles
cd ~
#git clone -b beanaroo --single-branch https://github.com/CatPhat/dotfiles.git  ~/dotfiles
cd dotfiles/setup
fab install_environment
#fab install_environment_config
