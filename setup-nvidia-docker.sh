#!/usr/bin/env bash

./setup-docker.sh

if [[ "$(uname -s)" == 'Linux' ]] && [ -x "$(command -v apt)" ]; then
    # https://github.com/NVIDIA/nvidia-docker
    distribution=$(. /etc/os-release;echo "$ID""$VERSION_ID")
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/"$distribution"/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    sudo apt update && sudo apt install -y nvidia-container-toolkit
    sudo systemctl restart docker
fi
