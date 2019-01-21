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

@test "find_symlinks .envlink.config returns correct count" {
    run find_symlinks ".envlink.config"
    assert_equal "${#lines[@]}" 1
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

@test "symlink homelinks" {
    run symlink_homelinks

    assert_equal \
       "$(find_symlinks "homelink" | wc -l)" \
       "$(find $HOME -maxdepth 1 -type l | wc -l)"

     while read homelink ; do
         assert_equal \
             $(md5sum < ${homelink} | cut -d' ' -f1) \
             $(find $HOME -maxdepth 1 -type l -name .$(basename "${homelink%.*}") -exec md5sum {} \;  | cut -d' ' -f1)
     done < <(find_symlinks "homelink")
}

@test "symlink pathlinks" {
    export HOME=/home/pathlink-tests
    run symlink_pathlinks

    assert_equal \
       "$(find_symlinks "pathlink" | wc -l)" \
       "$(find $HOME -type l -exec ls {} \; | grep ".pathlink" | wc -l)"

     while read pathlink ; do

        local linked_parent_dir="$(dirname ${pathlink})"
        assert_equal \
            "$(dirname ${pathlink})" \
            "$(find $HOME -iname *${linked_parent_dir##*/} -exec readlink {} \;)"
     done < <(find_symlinks "pathlink")
}

@test "symlink envlinks fails on missing .envlink.config" {
    export HWENV="arch-test"
    export HOME="/home/test-missing-envlinks"
    local test_dir="${DOTFILES_ROOT}/failing-envlink-test/${HWENV}"
    local test_path="${test_dir}/.test.envlink"

    mkdir -p ${test_dir}
    touch "${test_path}"

    run symlink_envlinks
    rm -rf "${test_dir}"

    (echo "${output}" | grep -q "Could not find .envlink.config in ${test_dir}" ) && found=true || found=false
    assert_equal true ${found}

}

@test "symlink envlinks" {
    export HOME="/home/test-envlinks"
    run symlink_envlinks

    while read envlink ; do

        local linked="$(basename ${envlink})"
        assert_equal \
            ${envlink} \
            "$(find $HOME -name *${linked%.*}* -exec readlink {} \;)"

        assert_equal \
            $(md5sum < ${envlink} | cut -d' ' -f1) \
            "$(find $HOME -name *${linked%.*}* -exec md5sum {} \; | cut -d' ' -f1)"

    done < <(find_symlinks "envlink")

}

@test "backup_link_target_if_exists fails if target is directory" {
    local src_dir="${DOTFILES_ROOT}"
    local target_dir="${HOME}/backup-target-dir-fail-test"
    mkdir -p ${target_dir}

    run backup_link_target_if_exists "${src_dir}" "${target_dir}"
    assert_equal "${status}" "1"
}


