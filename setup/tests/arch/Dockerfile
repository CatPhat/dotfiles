FROM archlinux/base
MAINTAINER Kian Movasagi

ARG dotfiles_root
ENV env_dotfiles_root=${dotfiles_root}

ENV LANG=en_US.UTF-8
RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S sudo

RUN useradd -m tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

ENV USER tester
ENV HOME /home/tester

USER tester

COPY . ${env_dotfiles_root}

CMD ["/bin/bash"]
