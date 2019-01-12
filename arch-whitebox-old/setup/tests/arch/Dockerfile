FROM base/archlinux
MAINTAINER Kian Movasagi

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S coreutils sudo systemd

#pyyaml & libyaml deps
#RUN pacman --noconfirm -S python2 stow base-devel git libyaml python-yaml

RUN useradd -m tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

USER tester
ENV HOME /home/tester
ENV USER tester
RUN pwd
WORKDIR /home/tester/setup

ADD ./temp/arch-bootstrap.sh /home/tester/setup/arch-bootstrap.sh
RUN ./arch-bootstrap.sh

#RUN sudo pacman --noconfirm -Sy i3-gaps
#RUN sudo pacman --noconfirm -Sy rofi
#RUN sudo pacman --noconfirm -Sy compton
#RUN sudo pacman --noconfirm -Sy termite
#RUN sudo pacman --noconfirm -Sy tmux
#RUN sudo pacman --noconfirm -Sy ranger
#RUN sudo pacman --noconfirm -Sy stow
#RUN sudo pacman --noconfirm -Sy zathura
#RUN sudo pacman --noconfirm -Sy fish
#RUN sudo pacman --noconfirm -Sy neovim

#RUN mkdir /home/tester/dotfiles
#ADD ./temp/.config /home/tester/dotfiles/.config
#ADD ./temp/fabfile.py /home/tester/setup/fabfile.py
#ADD ./temp/utilities.py /home/tester/setup/utilities.py
#ADD ./temp/dependencies.yaml /home/tester/setup/dependencies.yaml
#RUN sudo chown -R tester:tester /home/tester

#RUN sudo pacman --noconfirm -Sy xorg-server-xephyr
#RUN Xephyr :0 -ac -br -screen 1024x768 -resizeable -reset -terminate

#RUN fab install_environment
#RUN fab install_environment_config
CMD ["/bin/bash"]

# configure ssh
# RUN sudo pacman -Sqyu --noconfirm --needed openssh && \
#    sudo systemctl enable sshd
#RUN sudo sed -i \
#        -e 's/^#*\(PermitRootLogin\) .*/\1 yes/' \
#        -e 's/^#*\(PasswordAuthentication\) .*/\1 yes/' \
#        -e 's/^#*\(PermitEmptyPasswords\) .*/\1 yes/' \
#        -e 's/^#*\(UsePAM\) .*/\1 no/' \
#        /etc/ssh/sshd_config
#EXPOSE 22
#CMD ["/usr/bin/init"]
#RUN /usr/bin/sshd -D
