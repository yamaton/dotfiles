#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFIG_DIR="${HOME}/.config/Code/User"

if [ "$1" = "-f" ] || [ ! -x "$(command -v code)" ]; then

    if [ -x $(uname -s) == "Linux" ] && [ -x $(command -v apt) ]; then
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt update
        sudo apt -y install code
    else
        echo "[INFO] skipping; vscode is already available"
    fi

else
    echo "[WARNING] code already exists; skipping installation (use -f for force install)"
fi

echo "[INFO] copying vscode settings.json to ${CONFIG_DIR}"
[ ! -d "${CONFIG_DIR}" ] && mkdir -p "${CONFIG_DIR}"
cp "${BASEDIR}/vscode/settings.json" "${CONFIG_DIR}/settings.json"
