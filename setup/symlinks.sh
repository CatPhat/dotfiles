#!/usr/bin/env bash

source "${DOTFILES}/setup/config.sh"
source "${DOTFILES}/setup/common.sh"

# takes the given source file and target path and backs up the existing target
# if the target exists and is not a symlink of the source.
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

#        if [[ -d ${target} ]]; then
#            fail "Target is a directory, must be a file."
#            exit 1
#        fi

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

function symlink_dotlinks() {
    info "Linking dotlinks."
    while read -r file ; do
        symlink_dotlink "$file"
    done < <(find_symlinks "dotlink")
    info "Done linking dotlinks.\n"
}

function symlink_dotlink(){
    # e.g. $DOTFILES/tmux
    # which contains files of type *.dotlink
    local src_dir=$1
    # e.g. $HOME/.config/tmux
    local desired_dst=$2

    # target is existing directory
    # symlink contents of source directory into target
    if [[ -d "${desired_dst}" ]]; then

        while read -r file ; do
    
            local src_dotlink_file=${file}
            local src_dotlink_file_name_only=${src_dotlink_file##*/}
            local dst_dotlink_file=${desired_dst}'/'${src_dotlink_file_name_only}

            backup_link_target_if_exists "${src_dotlink_file}" "${dst_dotlink_file}"
    
            # local dst_dotlink_file_parent_dir
            # dst_dotlink_file_parent_dir="$(dirname "${dst_dotlink_file}")"
            # [[ -e ${dst_dotlink_file_parent_dir} ]] \
            #     || info "${dst_dotlink_file_parent_dir} does not exist, making folder." && mkdir -p "${dst_dotlink_file_parent_dir}"
    
            if (ln -sf "${src_dotlink_file}" "${dst_dotlink_file}"); then
                success "Successfully linked ${src_dotlink_file} to ${dst_dotlink_file}"
            else
                fail "Could not link ${src_dotlink_file} to ${dst_dotlink_file}"
                return 1
            fi
        done < <(find_dotlink_files "${src_dir}")

    # target does not exist
    # symlink source directory to target directory
    elif [[ ! -e "${desired_dst}" ]]; then

        if (ln -sf "${src_dir}" "${desired_dst}"); then
            success "Successfully linked ${src_dir} to ${desired_dst}"
        else
            fail "Could not link ${src_dir} to ${desired_dst}"
            return 1
        fi

    # Unexpected case
    else

        fail "Something went wrong while linking ${src_dir} to ${desired_dst}."
        return 1
    fi

}

function validate_dotlink(){
    # e.g. $DOTFILES/tmux
    # which contains files of type *.dotlink
    local src_dir=$1
    # e.g. $HOME/.config
    local desired_dst=$2

    while read -r file ; do
        local src_dotlink_file=${file}
        local src_dotlink_file_name_only=${src_dotlink_file##*/}

        local dst_dotlink_file=${desired_dst}'/'${src_dotlink_file_name_only}
        local dst_dotlink_file_parent_dir
        dst_dotlink_file_parent_dir="$(dirname "${dst_dotlink_file}")"


        if [[ $(readlink -f "${dst_dotlink_file}") == "${src_dotlink_file}" ]]; then
            if $DEBUG; then
                success "${src_dotlink_file} and ${dst_dotlink_file} are symlinked"
            fi
        else
            if $DEBUG; then
                fail "${src_dotlink_file} and ${dst_dotlink_file} are not valid symlinks"
            fi
            return 1
        fi
    done < <(find_dotlink_files "${src_dir}")

    return 0
}

function find_dotlink_files() {
    local dir="$1"
    find "${dir}"  -maxdepth 1 ! -name '._*'
}