#!/usr/bin/env bats

load helpers
source ${SETUP_INSTALL}


@test "find_install_scripts exit status" {
    run find_install_scripts
    assert_equal 20 "${#lines[@]}"
}

@test "setup prequisites for OSENV arch install" {
# Installed via Dockerfile to allow for caching
#    run execute_dotfile_setup_prequisite_scripts
    assert_equal "/usr/sbin/git" "$(command -v git)"
    assert_equal "/usr/sbin/zsh" "$(command -v zsh)"
    assert_equal "/usr/sbin/trizen" "$(command -v trizen)"
}

@test "dotfile bin installs" {
# Installed via Dockerfile to allow for caching
#    run execute_dotfile_install_scripts
    assert_equal "/usr/sbin/antibody" "$(command -v antibody)"
    assert_equal "/usr/sbin/compton" "$(command -v compton)"
    assert_equal "/usr/sbin/docker" "$(command -v docker)"
    assert_equal "/usr/sbin/feh" "$(command -v feh)"
    assert_equal "/usr/sbin/fzf" "$(command -v fzf)"
    assert_equal "/usr/sbin/go" "$(command -v go)"
    assert_equal "/usr/sbin/gtk3-demo" "$(command -v gtk3-demo)"
    assert_equal "/usr/sbin/i3" "$(command -v i3)"
    assert_equal "/usr/sbin/ffmpeg" "$(command -v ffmpeg)"
    assert_equal "/usr/sbin/mpv" "$(command -v mpv)"
    assert_equal "/usr/sbin/nvim" "$(command -v nvim)"
    assert_equal "/usr/sbin/polybar" "$(command -v polybar)"
    assert_equal "/usr/sbin/termite" "$(command -v termite)"
    assert_equal "/usr/sbin/tmux" "$(command -v tmux)"
    assert_equal "/usr/sbin/zathura" "$(command -v zathura)"
}

# TODO: add tests for terminal, browser, etc..
@test "fonts are installed" {
# Should already be installed via Dockerfile
    local nerd_is_installed=false
    fc-list | grep -q "nerd-fonts-complete" && nerd_is_installed=true
    assert_equal ${nerd_is_installed} true

    local noto_is_installed=false
    fc-list | grep -q "noto" && noto_is_installed=true
    assert_equal ${noto_is_installed} true

}

# TODO: validate go env variables
@test "validate go install" {
    run echo "${GOPATH}"
    assert_equal "${GOPATH}" "${output}"

    hello=$(cat <<EOF
package main;
import "fmt";
func main() {
    fmt.Println("Hello, Arch!");
}
EOF
)

    touch /tmp/hello.go
    echo -e ${hello} > /tmp/hello.go
    run go run /tmp/hello.go
    assert_equal 'Hello, Arch!' "${output}"
}

# TODO: validate sourced file
@test "validate base16 oceanic shell install" {
    local expected_oceanic_source='source ${DOTFILES}/oceanic-next-shell/.source.zshrc.sh'

    run echo $(grep -q "${expected_oceanic_source}" ${DOTFILES_ZSHRC} \
        && echo "exists" || echo "does not exist")

    assert_equal "exists" "${output}"
}
