FROM archlinux/base
MAINTAINER Kian Movasagi

ARG dotfiles_root
ARG host_user
ENV DOTFILES=${dotfiles_root}
ENV USER=${host_user}
ENV HOME /home/${USER}

ENV LANG=en_US.UTF-8
RUN pacman -Syu --needed --noconfirm sudo

RUN useradd -m ${USER}
RUN echo "${USER}   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers
USER ${USER}

# Dotfile setup prequisites
COPY ./setup/setup_prequisites.arch.sh ${DOTFILES}/setup/setup_prequisites.arch.sh
RUN bash ${DOTFILES}/setup/setup_prequisites.arch.sh

# Git
COPY ./git ${DOTFILES}/git
RUN bash ${DOTFILES}/git/.install.arch.sh

# BATS-Core unit tests
RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core

# Trizen
COPY ./trizen ${DOTFILES}/trizen
RUN bash ${DOTFILES}/trizen/.install.arch.sh

# ZSH
COPY ./zsh ${DOTFILES}/zsh
RUN bash ${DOTFILES}/zsh/.install.arch.sh

# Antibody
COPY ./antibody ${DOTFILES}/antibody
RUN zsh ${DOTFILES}/antibody/.install.arch.sh

# Compton
COPY ./compton ${DOTFILES}/compton
RUN zsh ${DOTFILES}/compton/.install.arch.sh

# Docker
COPY ./docker ${DOTFILES}/docker
RUN zsh ${DOTFILES}/docker/.install.arch.sh

# Feh
COPY ./feh ${DOTFILES}/feh
RUN zsh ${DOTFILES}/feh/.install.arch.sh

# Fonts
COPY ./fonts ${DOTFILES}/fonts
RUN zsh ${DOTFILES}/fonts/.install.arch.sh

# Fzf
COPY ./fzf ${DOTFILES}/fzf
RUN zsh ${DOTFILES}/fzf/.install.arch.sh

#TODO: move to top
COPY ./setup/common.sh ${DOTFILES}/setup/common.sh
COPY ./setup/config.sh ${DOTFILES}/setup/config.sh
RUN sudo chown -R ${USER}:${USER} ${HOME}

# Go
COPY ./golang ${DOTFILES}/golang
RUN zsh ${DOTFILES}/golang/.install.arch.sh

# gtk-3.0
COPY ./gtk-3.0 ${DOTFILES}/gtk-3.0
RUN zsh ${DOTFILES}/gtk-3.0/.install.arch.sh

# i3
COPY ./i3 ${DOTFILES}/i3
RUN zsh ${DOTFILES}/i3/.install.arch.sh

# ffmpeg
# TODO: set FULL_FFMPEG_NVENC via setup/config
#       add question at initializaton.
COPY ./ffmpeg ${DOTFILES}/ffmpeg
RUN zsh ${DOTFILES}/ffmpeg/.install.arch.sh

# mpv
COPY ./mpv ${DOTFILES}/mpv
RUN zsh ${DOTFILES}/mpv/.install.arch.sh

# nvim
COPY ./nvim ${DOTFILES}/nvim
RUN zsh ${DOTFILES}/nvim/.install.arch.sh

# oceanic-next-shell
COPY ./oceanic-next-shell ${DOTFILES}/oceanic-next-shell
RUN sudo chown -R ${USER}:${USER} ${HOME}
RUN zsh ${DOTFILES}/oceanic-next-shell/.install.arch.sh

# TODO: DELETE ME
RUN sudo reflector --verbose --latest 40 --number 10 --sort rate --protocol http --save /etc/pacman.d/mirrorlist
RUN sudo pacman -Syu --needed --noconfirm

# polybar
COPY ./polybar ${DOTFILES}/polybar
RUN zsh ${DOTFILES}/polybar/.install.arch.sh



#Setup and associated BAT tests
COPY ./setup/install.sh ${DOTFILES}/setup/install.sh
COPY ./setup/tests/bats/helpers.bash ${DOTFILES}/setup/tests/bats/helpers.bash
COPY ./setup/tests/bats/test-install.bats ${DOTFILES}/setup/tests/bats/test-install.bats


#CMD ["bash"]
ENTRYPOINT ["zsh", "/tmp/bats-core/bin/bats"]
