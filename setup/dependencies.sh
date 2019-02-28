#!/usr/bin/env bash

script_path=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo "$0")
script_dir=$(dirname "${script_path}")

source "${script_dir}/config.sh"

"${script_dir}/dependencies.${OSENV}.sh"