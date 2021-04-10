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
        OS="$(lsb_release -is | sed 's/Pop/Ubuntu/' | tr '[:upper:]' '[:lower:]')"
        readonly OS
        curl -fsSL https://download.docker.com/linux/"$OS"/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
            "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
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


BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
COMPOSE_VERSION="$("$BASEDIR"/get-version-github.sh docker/compose)"
if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v docker-compose)" ]]; then
    echo "--------------------------------"
    echo "     Install docker-compose     "
    echo "--------------------------------"
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Installed docker-compose"
    docker-compose -v
fi

echo "-------------------------"
echo "   Running hello world"
echo "-------------------------"
sudo docker container run --rm hello-world


