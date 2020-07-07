#!/usr/bin/env bash

if [[ ! -x "$(command -v docker)" ]] || [[ "$1" == "-f" ]]; then
    if [[ "$(lsb_release -c -s)" == "focal" ]]; then
        sudo apt install docker.io
        sudo systemctl enable --now docker
        sudo usermod -aG docker "$USER"
    elif [[ -x "$(command -v apt)" ]]; then
        echo "---- Install docker ----"
        sudo apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common
        sudo apt autoremove -y docker docker-engine docker.io containerd runc
        sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg-agent
        OS="$(lsb_release -is | tr '[:upper:]' '[:lower:]')"
        readonly OS
        curl -fsSL "https://download.docker.com/linux/$OS/gpg" | sudo apt-key add -

        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$OS $(lsb_release -cs) stable"
        sudo apt-key fingerprint 0EBFCD88
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io
        sudo usermod -aG docker "$USER"

        echo "================================================"
        echo "   logout once to call docker without sudo "
        echo "================================================"
        sudo docker -v
    fi
else
    echo "docker is already available"
    docker -v
fi


COMPOSE_VERSION=1.26.0
if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v docker-compose)" ]]; then
    echo "---- Install docker-compose ----"
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Installed docker-compose"
    docker-compose -v
fi

echo "-------------------------"
echo "   Running hello world"
echo "-------------------------"
sudo docker container run --rm hello-world


