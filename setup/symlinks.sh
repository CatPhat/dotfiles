#!/usr/bin/env bash

#source "${DOTFILES_ROOT}/setup/config.sh"
#source "${DOTFILES_ROOT}/setup/common.sh"

# Find files with the specified symlink file type
# Available symlink types: .symlink | .envlink | .pathlink
function find_symlinks() {
    local __symlink_file_type=$1
#   local __result=()
    while IFS= read -d $'\0' -r file ; do
#       __result=("${__result[@]}" "$file")
        echo "$file"
    done < <(find -H ${DOTFILES_ROOT} -name "*.$__symlink_file_type" -not -path '*.git*' -print0)
#   echo "${__result[@]}"
}

link_file() {
    debug "\$2 readlink: $(readlink $2)"
	if [ -e "$2" ]; then
		if [ "$(readlink "$2")" = "$1" ]; then
			success "skipped, valid existing symlink found \n \
            target: $1 \n \
              link: $2"
			return 0
		else
#			mv "$2" "$2.backup"
			success "moved $2 to $2.backup"
		fi
	fi
	ln -sf "$1" "$2"
	success "linked $1 to $2"
}

install_symlinks() {
	info 'installing symlinks into $HOME'
	find -H "$DOTFILES_ROOT" -maxdepth 3 -name '*.symlink' -not -path '*.git*' |
		while read -r src; do
			dst="$HOME/.$(basename "${src%.*}")"
			link_file "$src" "$dst"
		done
}

install_hwenv_symlinks() {
	info 'installing symlinks based on Hardware environment into $HOME'
	find -H "$DOTFILES_ROOT" -maxdepth 3 -name '*.envlink' -not -path '*.git*' |
		while read -r src; do
            debug $src
            if [[ $src =~ .*$HWENV.* ]]; then
	            dst="$HOME/.$(basename "${src%.*}")"
			    link_file "$src" "$dst"
            fi
		done
}


install_hwenv_symlinks_with_config_path(){
    info 'installing symlinks based on the \$HWENV env value with specified parent folder'
}

# 'returns' and validates the output of a config.pathlink file
parse_config_pathlink_file() {
    desired_path=$(cat "$1")
    if [[ $(wc -l <"$1") -eq 1 ]]; then
        echo $(eval "echo $desired_path")
    else
        fail "Invalid number of lines in $1 \n \
        Should be only 1 line with a full path to the desired symlink location.\n \
        e.g.: \"\$HOME/.config\""
    fi
}

# If a directory contains 'config.pathlink' then this will symlink
# the parent folder name to the desired root folder specified in
# the respective 'config.pathlink' file.
# e.g.:
#       > cat ~/.dotfiles/compton/config.pathlink
#       "$HOME/.config"
#       > full_symlink_target_path=$("$HOME/.config/compton")
install_symlinks_with_config_path() {
    info 'installing symlinks with specified parent folder'
	find -H "$DOTFILES_ROOT" -maxdepth 3 -name 'config.pathlink' -not -path '*.git*' |
        while read -r src; do
            desired_path=$(parse_config_pathlink_file "$src")
            src_path=$(dirname $src)
            # get relative path from the resulting difference
            rpath="${src_path#"$DOTFILES_ROOT"}"
            dst_path="$desired_path/$rpath"
            debug "src: $src"
            debug "desired_path: $desired_path"
            debug "rpath: $rpath"
            debug "src_path: $src_path"
            debug "dst_path: $dst_path"
            link_file "$src_path" "$dst_path"
        done
}


