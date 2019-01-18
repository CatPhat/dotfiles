#!/usr/bin/env bash

source "${DOTFILES_ROOT}/setup/config.sh"
source "${DOTFILES_ROOT}/setup/common.sh"

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

# takes the given source file and target path and backs up the existing target
# if the target exists and is not a symlink of the source.
# TODO: this should only target files and not directories
function backup_link_target_if_exists() {
    local src="$1"
    local target="$2"

    local backup_folder="${DOTFILES_ROOT}/.backup"
    local backup_logfile="${backup_folder}/backup.log"
    local backup_date=$(date '+%Y-%m-%d.%H:%M:%S')
    local target_parent_dir="$(dirname ${target})"
    local backup_target_dest="${backup_folder}/${backup_date}-${target_parent_dir##*/}-$(basename ${target})"

    info "Checking if target needs to be backed up \n
               src: ${src} \n
            target: ${target}"
    if [[ -e ${target} ]]; then
        if [[ $(readlink ${target}) == ${src} ]]; then
            info 'link target matches source, ignoring.'
        else
            info "link target exists, moving to ${backup_target_dest}"

            [[ -d ${backup_folder} ]] || mkdir ${backup_folder}
            [[ -f ${backup_logfile} ]] || touch ${backup_logfile}

            mv "${target}" "${backup_target_dest}"
            echo "${backup_date} - Moved ${target} to ${backup_target_dest}" >> ${backup_logfile}
        fi
    else
        info "target does not exist, not backing up ${target}"
    fi
}

function symlink_homelinks() {
    info "linking homelinks"
    while read file ; do
		local dst="$HOME/.$(basename "${file%.*}")"
        backup_link_target_if_exists "${file}" "${dst}"
        ln -sf "${file}" "${dst}"
        success "Successfully linked ${file} to ${dst}"
    done < <(find_symlinks "homelink")
    info "Done linking homelinks\n"
}

# If a directory contains 'config.pathlink' then this will symlink
# the parent folder name to the desired root folder specified in
# the respective 'config.pathlink' file.
# e.g.:
#       > cat ~/.dotfiles/compton/config.pathlink
#       "$HOME/.config"
#       > full_symlink_target_path=$("$HOME/.config/compton")
function symlink_pathlinks() {
    info "Linking pathlinks."
    while read file ; do
        local desired_path=$(parse_symlink_config_file "${file}")
        info ${desired_path}
        local src_parent_folder=$(dirname ${file})
        local dst="$desired_path/${src_parent_folder##*/}"

        backup_link_target_if_exists "${src_parent_folder}" "${dst}"

        [[ -e $(dirname ${dst}) ]] \
            || info "$(dirname ${dst}) does not exist, making folder." && mkdir -p $(dirname ${dst})

        ln -sf "${src_parent_folder}" "${dst}" \
            && success "Successfully linked ${src_parent_folder} to ${dst}" \
            || fail "Could not link ${src_parent_folder} to ${dst}"

    done < <(find_symlinks "pathlink")
    info "Done linking pathlinks.\n"
}

function symlink_envlinks() {
    info "Linking envlinks by ${HWENV}."
    while read file ; do

        debug ${file}
        local src_parent_folder=$(dirname ${file})
        debug ${src_parent_folder}
        local envlink_config_file=$(find ${src_parent_folder} -name '.envlink.config')
        debug ${envlink_config_file}

#        if [[ ${file} =~ '*envlink.config' ]]; then
#            fail "Skipping ${config_file}"
#            continue
#        fi

        if [[ ! -e ${envlink_config_file} ]]; then
            fail "Could not find .envlink.config in ${src_parent_folder}"
            continue
        else
            info "Using .envlink.config found in ${src_parent_folder}"
        fi

        local file_basename=$(basename ${file})
        local desired_path=$(parse_symlink_config_file "${envlink_config_file}")
        local dst="$desired_path/.${file_basename%.*}"
        backup_link_target_if_exists "${file}" "${dst}"

        [[ -e ${desired_path} ]] \
            || info "${desired_path} does not exist, making folder." && mkdir -p ${desired_path}

        ln -sf "${file}" "${dst}" \
            && success "Successfully linked ${file} to ${dst}" \
            || fail "Could not link ${file} to ${dst}"

    done < <(find_symlinks "envlink")
    info "Done linking envlinks."

}


# 'returns' and validates the output of the provided file
function parse_symlink_config_file() {
    local desired_path=$(. <(echo -e echo $(<$1)))
    if [[ $(wc -l <"$1") -eq 1 ]]; then
        echo "${desired_path}"
    else
        fail "Invalid number of lines in $1 \n \
        Should be only 1 line with a full path to the desired symlink location.\n \
        e.g.: \"\$HOME/.config\""
    fi
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
			link_file "${src}" "${dst}"
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

