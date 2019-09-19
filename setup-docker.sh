#!/usr/bin/env bash
if [ "$1" = "-f" ] || [ ! -x "$(command -v docker)" ]; then
if [ -x apt ]; then
sudo apt autoremove docker docker-engine docker.io containerd runc
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg-agent
OS=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
curl -fsSL "https://download.docker.com/linux/$OS/gpg" | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$OS $(lsb_release -cs) stable"
sudo apt-key fingerprint 0EBFCD88
sudo apt install docker-ce
sudo usermod -aG docker "$USER"
docker -v
fi
fi

