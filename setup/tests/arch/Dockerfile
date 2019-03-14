FROM archlinux/base
MAINTAINER Kian Movasagi

ARG dotfiles_root
ARG host_user
ENV DOTFILES=${dotfiles_root}
ENV USER=${host_user}
ENV HOME /home/${USER}
ENV LANG=en_US.UTF-8

RUN pacman -Syu --needed --noconfirm \
        base base-devel reflector sudo make 
		
RUN sudo reflector --verbose --latest 40 \
        --number 10 --sort rate --protocol http \
        --save /etc/pacman.d/mirrorlist

RUN sed 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
        /etc/sudoers > /etc/sudoers.new

RUN bash -c "export EDITOR='cp /etc/sudoers.new'; visudo"
RUN rm /etc/sudoers.new
RUN useradd -m -g users -G wheel -s /bin/bash ${USER} \
    && chown -R ${USER} /home/${USER}
USER ${USER}

#
#
## Git
COPY ./git ${DOTFILES}/git
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup git"
#
## Trizen
#COPY ./trizen ${DOTFILES}/trizen
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup trizen"
#
## x
## TODO: Does x need an install script?
COPY ./x ${DOTFILES}/x
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup x"
#
## ZSH
COPY ./zshrc.d ${DOTFILES}/zshrc.d
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

# Using Docker was a mistake.
# Step 25/46 : COPY ./compton ${DOTFILES}/compton
# failed to export image: failed to create image: failed to get layer sha256:4438293011f6960e1b266375b6910e0136d8b08cdbc4fca6e42ee6ea484da0d3: layer does not exist
# https://github.com/moby/moby/issues/37965#issuecomment-426853382
RUN true

## Compton
COPY ./compton ${DOTFILES}/compton
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup compton"

#
## Fzf
COPY ./fzf ${DOTFILES}/fzf
#RUN bash -c "source ${DOTFILES}/setup/setup_dotfile.sh; setup fzf"

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
## BATS-Core unit tests
#RUN git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
#
## Bats tests
#COPY ./setup/tests/bats/helpers.bash ${DOTFILES}/setup/tests/bats/helpers.bash
#COPY ./setup/tests/bats/test-setup.bats ${DOTFILES}/setup/tests/bats/test-setup.bats
#
#COPY ./setup/symlinks.sh ${DOTFILES}/setup/symlinks.sh
#COPY ./setup/tests/bats/test-symlinks.bats ${DOTFILES}/setup/tests/bats/test-symlinks.bats


# TODO: DELETE, here to speed up testing

RUN sudo pacman -Syu --noconfirm --needed git
RUN git clone https://aur.archlinux.org/trizen.git  /tmp/trizen \
    && cd /tmp/trizen \
    && makepkg -si --noconfirm
RUN trizen -Syu --noconfirm --needed antibody-bin compton-git
RUN sudo pacman -S --noconfirm --needed docker feh ffmpeg

COPY ./configure ${DOTFILES}/
COPY ./Makefile.in ${DOTFILES}/
RUN sudo chown -R ${USER} ${DOTFILES}

#RUN bash -c "cd ${DOTFILES}; make status"
#RUN bash -c "cd ${DOTFILES}; make install_trizen"
#RUN bash -c "cd ${DOTFILES}; make install_antibody"
#RUN bash -c "cd ${DOTFILES}; make stow_antibody"

RUN cd ${DOTFILES} && ./configure --osenv=arch --hwenv=whitebox
RUN cd ${DOTFILES} && make antibody
RUN cd ${DOTFILES} && make compton
RUN cd ${DOTFILES} && make docker
RUN cd ${DOTFILES} && make feh
RUN cd ${DOTFILES} && make ffmpeg
#RUN cd ${DOTFILES} && make fonts
RUN cd ${DOTFILES} && make fzf
RUN cd ${DOTFILES} && make install-all-arch

RUN ls -lha $HOME
RUN ls -lha $HOME/.config

ENTRYPOINT ["bash", "/tmp/bats-core/bin/bats"]