#!/bin/bash
sudo rmmod pcspkr
sudo -s echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
