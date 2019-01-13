#!/usr/bin/env bash

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)


DEBUG=false
HWENV="arch-macbook"

setup_gitconfig() {
	info 'setup gitconfig'
	# if there is no user.email, we'll assume it's a new machine/setup and ask it
	if [ -z "$(git config --global --get user.email)" ]; then
		user ' - What is your github author name?'
		read -r user_name
		user ' - What is your github author email?'
		read -r user_email

		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	elif [ "$(git config --global --get dotfiles.managed)" != "true" ]; then
		# if user.email exists, let's check for dotfiles.managed config. If it is
		# not true, we'll backup the gitconfig file and set previous user.email and
		# user.name in the new one
		user_name="$(git config --global --get user.name)"
		user_email="$(git config --global --get user.email)"
		mv ~/.gitconfig ~/.gitconfig.backup
		success "moved ~/.gitconfig to ~/.gitconfig.backup"
		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	else
		# otherwise this gitconfig was already made by the dotfiles
		info "already managed by dotfiles"
	fi
	# include the gitconfig.local file
	git config --global include.path ~/.gitconfig.local
	# finally make git knows this is a managed config already, preventing later
	# overrides by this script
	git config --global dotfiles.managed true
	success 'gitconfig'
}
find_zsh() {
	if which zsh >/dev/null 2>&1 && grep "$(which zsh)" /etc/shells >/dev/null; then
		which zsh
	else
		echo "/bin/zsh"
	fi
}

#setup_gitconfig
#install_symlinks
#install_hwenv_symlinks
#install_symlinks_with_config_path
#
#info "installing dependencies"
#if ./bin/dot_update; then
#	success "dependencies installed"
#else
#	fail "error installing dependencies"
#fi
#
#zsh="$(find_zsh)"
#test -z "$TRAVIS_JOB_ID" &&
#	test "$(expr "$SHELL" : '.*/\(.*\)')" != "zsh" &&
#	which chsh >/dev/null 2>&1 &&
#	chsh -s "$zsh" &&
#	success "set $("$zsh" --version) at $zsh as default shell"
#
#echo ''
#echo '  All installed!'
