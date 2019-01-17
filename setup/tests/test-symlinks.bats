#!/usr/bin/env bats

load helpers
source ${SETUP_SYMLINKS}

@test "find_symlinks exit status" {
    run find_symlinks "symlink"
    assert_equal "$status" 0
}

@test "find_symlinks .homelink returns correct count" {
    run find_symlinks "homelink"
    assert_equal "${#lines[@]}" 4
}

@test "find_symlinks .envlink returns correct count" {
    run find_symlinks "envlink"
    assert_equal "${#lines[@]}" 5
}

@test "find_symlinks .pathlink returns correct count" {
    run find_symlinks "pathlink"
    assert_equal "${#lines[@]}" 12
}

@test "backup_link_target_if_exists by source file and none existing target" {
    local src_file="${DOTFILES_ROOT}/src/src.txt"
    local target_dst="${DOTFILES_ROOT}/.config/target/src.txt"
    mkdir -p "$(dirname "${src_file}")"
    touch ${src_file}

    run backup_link_target_if_exists ${src_file} ${target_dst}

    [[ -e ${DOTFILES_ROOT}/.backup ]] && backup_dir_exists=true || backup_dir_exists=false
    assert_equal ${backup_dir_exists} false
}

@test "backup_link_target_if_exists by source file existing target" {
    local src_file="${DOTFILES_ROOT}/src/src.txt"
    local target_file="${DOTFILES_ROOT}/.config/target/src.txt"
    local backup_dir="${DOTFILES_ROOT}/.backup/"

    mkdir -p "$(dirname "${src_file}")"
    mkdir -p "$(dirname "${target_file}")"
    touch "${src_file}"
    touch "${target_file}"
    local random_string="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)"
	echo ${random_string} >> ${target_file}

    run backup_link_target_if_exists "${src_file}" "${target_file}"

    [[ -e ${backup_dir} ]] && backup_dir_exists=true || backup_dir_exists=false
    assert_equal ${backup_dir_exists} true

    [[ -e ${target_file} ]] && existing_target_exists=true || existing_target_exists=false
    assert_equal ${existing_target_exists} false

    assert_equal "$(find ${backup_dir} -exec echo \; | wc -l)" 3

    assert_equal "$(find ${backup_dir} -name '*src.txt' -exec cat {} \;)" "${random_string}"

    rm -rf "${backup_dir}"
}

@test "backup_link_target_if_exists by source file and valid existing symlink" {
    local src_file="${DOTFILES_ROOT}/src-symlink/src.txt"
    local target_file="${DOTFILES_ROOT}/.config/target-symlink/src.txt"
    local backup_dir="${DOTFILES_ROOT}/.backup/"

    mkdir -p "$(dirname "${src_file}")"
    mkdir -p "$(dirname "${target_file}")"
    touch "${src_file}"
    local random_string="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c10)"
	echo ${random_string} >> ${src_file}
    ln -sf "${src_file}" "${target_file}"

    run backup_link_target_if_exists "${src_file}" "${target_file}"

    [[ $(readlink ${target_file}) == ${src_file} ]] && valid_existing_symlink=true || valid_existing_symlink=false
    assert_equal ${valid_existing_symlink} true

    [[ -f ${target_file} ]] && existing_target_exists=true || existing_target_exists=false
    assert_equal ${existing_target_exists} true

    assert_equal "$(cat ${target_file})" "${random_string}"
}
