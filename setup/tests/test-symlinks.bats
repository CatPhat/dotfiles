#!/usr/bin/env bats

load helpers
source ${SETUP_SYMLINKS}

@test "find_symlinks exit status" {
    run find_symlinks "symlink"
    assert_equal "$status" 0
}

@test "find_symlinks .symlink returns correct count" {
    run find_symlinks "symlink"
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
