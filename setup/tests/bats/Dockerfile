FROM bats/bats
MAINTAINER Kian Movasagi

ARG dotfiles_root
ENV env_dotfiles_root=${dotfiles_root}

ENV LANG=en_US.UTF-8

RUN apk add ncurses
COPY . ${env_dotfiles_root}

ENTRYPOINT ["bash", "/usr/sbin/bats"]
