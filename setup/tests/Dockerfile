FROM bats/bats:latest
ARG dotfiles_root
RUN apk add ncurses
ENV env_dotfiles_root=${dotfiles_root}

COPY . ${env_dotfiles_root}

ENTRYPOINT ["bash", "/usr/sbin/bats"]
