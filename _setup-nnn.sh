#!/usr/bin/env bash

# * Usage
# Run `./_setup-nnn.sh <repo-root>`
# Then it will clone nnn under <repo-root> and install it.

CMD=nnn
VERSION=$(curl --silent https://formulae.brew.sh/api/formula-linux/${CMD}.json | jq '.versions.stable' | tr -d \")
CURRENT=$($CMD -v)
if [ -x "$(command -v $CMD)" ] && [ $VERSION == $CURRENT ]; then
    echo "Current version is the latest: ${CMD} ${CURRENT}"
    exit 1
else
    echo "Update available: ${VERSION} (current ${CURRENT})"
fi

REPO_DIR="${HOME}/confs"
mkdir -p "$REPO_DIR"

if [ "$1" = "-f" ] || [ ! -x "$(command -v nnn)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    else
        codename=$(lsb_release -s -c)
        case "$codename" in
            "bionic")
                OS="ubuntu18.04";;
            "xenial")
                OS="ubuntu16.04";;
            "stretch")
                OS="debian9";;
            "buster")
                OS="debian10";;
            *)
                OS="";;
        esac

        cd "${REPO_DIR}" || exit
        if [ ! -z "$OS" ] && [ "$(uname -m)" == "x86_64" ]; then
            echo "[INFO] getting deb file for $codename"
            URI="https://github.com/jarun/nnn/releases/download/v${VERSION}/nnn_${VERSION}-1_${OS}.amd64.deb"
            wget -N "$URI"
            FILE=$(basename "$URI")
            sudo apt install ./"$FILE"
            rm -f ./"$FILE"
        else
            echo "[INFO] prepare to build nnn"
            sudo apt install -y libncursesw5-dev libreadline-dev

            echo "[INFO] build nnn"
            echo "REPO_DIR: ${REPO_DIR}"
            if [ ! -d nnn ]; then
                git clone https://github.com/jarun/nnn.git
                cd nnn
            else
                cd nnn
                git pull
            fi
            make
            sudo make install
        fi
    fi
fi
