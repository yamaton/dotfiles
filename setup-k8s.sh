#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux

# kubectl
if [[ "$1" == "-f" ]] || [[ ! "$(command -v kubectl)" ]]; then
    if [[ "$(command -v apt)" ]]; then
        sudo apt update && sudo apt install -y apt-transport-https
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
        sudo apt update
        sudo apt install -y kubectl
    elif [[ "$(command -v brew)" ]]; then
        brew install kubernetes-cli
    fi
fi

# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& chmod +x minikube
sudo install minikube /usr/local/bin
