FROM archlinux/base
MAINTAINER Kian Movasagi

ARG dotfiles_root
ARG host_user
ENV DOTFILES=${dotfiles_root}
ENV USER=${host_user}
ENV HOME /home/${USER}

ENV LANG=en_US.UTF-8
RUN pacman -Syu --needed --noconfirm sudo

RUN sed 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers > /etc/sudoers.new
RUN bash -c "export EDITOR='cp /etc/sudoers.new'; visudo"
RUN rm /etc/sudoers.new
RUN useradd -m -g users -G wheel -s /bin/bash ${USER} \
    && chown -R ${USER} /home/${USER}
USER ${USER}

COPY ./setup/config.sh ${DOTFILES}/setup/
COPY ./setup/dependencies.sh ${DOTFILES}/setup/
COPY ./setup/dependencies.arch.sh ${DOTFILES}/setup/
RUN bash -c "${DOTFILES}/setup/dependencies.sh"
#RUN sudo chown -R ${USER} ${DOTFILES}

#
#
## Git
COPY ./git ${DOTFILES}/git
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup git"
#
## Trizen
COPY ./trizen ${DOTFILES}/trizen
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup trizen"
#
## x
## TODO: Does x need an install script?
COPY ./x ${DOTFILES}/x
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup x"
#
## ZSH
COPY ./zsh ${DOTFILES}/zsh
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup zsh"
#
## Antibody
COPY ./antibody ${DOTFILES}/antibody
#RUN sudo chown -R ${USER}:${USER} ${HOME}
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup antibody"
#
## x
## TODO: Does x need an install script?
COPY ./x ${DOTFILES}/x
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup x"
#
## Compton
COPY ./compton ${DOTFILES}/compton
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup compton"
#
## Docker
COPY ./docker ${DOTFILES}/docker
##RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup docker"
#
## ffmpeg
## TODO: set FULL_FFMPEG_NVENC via setup/config
##       add question at initializaton.
COPY ./ffmpeg ${DOTFILES}/ffmpeg
##RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup ffmpeg"
#
## Fonts
COPY ./fonts ${DOTFILES}/fonts
##RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup fonts"
#
## Fzf
COPY ./fzf ${DOTFILES}/fzf
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup fzf"
#
## Go
COPY ./golang ${DOTFILES}/golang
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup golang"
#
## gtk-3.0
COPY ./gtk-3.0 ${DOTFILES}/gtk-3.0
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup gtk-3.0"
#
## i3
COPY ./i3 ${DOTFILES}/i3
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup i3"
#
## mpv
COPY ./mpv ${DOTFILES}/mpv
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup mpv"
#
## nvim
COPY ./nvim ${DOTFILES}/nvim
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup nvim"
#
## oceanic-next-shell
COPY ./oceanic-next-shell ${DOTFILES}/oceanic-next-shell
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup oceanic-next-shell"
#
## polybar
COPY ./polybar ${DOTFILES}/polybar
##RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup polybar"
#
## rofi
COPY ./rofi ${DOTFILES}/rofi
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup rofi"
#
## TODO: Think about how to install/configure ssh
## TODO: Think about how to handle 'system' aliases
##       e.g.: alias pbcopy="xclip -selection clipboard"
## termite
COPY ./termite ${DOTFILES}/termite
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup termite"
#
## tmux
COPY ./tmux ${DOTFILES}/tmux
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup tmux"
#
## zathura
COPY ./zathura ${DOTFILES}/zathura
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup zathura"
#
## Feh
COPY ./feh ${DOTFILES}/feh
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup feh"
#
## BATS-Core unit tests
#RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
#
## Bats tests
#COPY ./setup/tests/bats/helpers.bash ${DOTFILES}/setup/tests/bats/helpers.bash
#COPY ./setup/tests/bats/test-setup.bats ${DOTFILES}/setup/tests/bats/test-setup.bats
#
#COPY ./setup/symlinks.sh ${DOTFILES}/setup/symlinks.sh
#COPY ./setup/tests/bats/test-symlinks.bats ${DOTFILES}/setup/tests/bats/test-symlinks.bats

COPY ./Makefile ${DOTFILES}/
COPY ./setup/common.sh ${DOTFILES}/setup/
COPY ./setup/status.sh ${DOTFILES}/setup/
RUN bash -c "cd ${DOTFILES}; make status"

ENTRYPOINT ["bash", "/tmp/bats-core/bin/bats"]