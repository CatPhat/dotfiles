#!/usr/bin/env bash

script_path=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo "$0")
script_dir=$(dirname "${script_path}")
DOTFILES=${script_dir}/../

DEBUG=false
HWENV="arch-whitebox"
OSENV="arch"
GOPATH="$HOME/dev/go"
DOTFILES_ZSHRC="${DOTFILES}/zsh/.zshrc"
FULL_FFMPEG_NVENC=false
