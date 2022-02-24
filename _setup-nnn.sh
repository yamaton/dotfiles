#!/usr/bin/env bash

# * Usage
# Run `./_setup-nnn.sh <repo-root>`
# Then it will clone nnn under <repo-root> and install it.

readonly CMD=nnn
VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$($CMD -V)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

readonly REPO_DIR="${HOME}/confs"
mkdir -p "$REPO_DIR"

if [[ "$1" == "-f" ]] || [[ ! "$(command -v nnn)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    else
        codename="$(lsb_release -s -c)"
        case "$codename" in
        "focal") OS="xUbuntu_20.04" ;;
        "buster") OS="Debian_10" ;;
        "groovy") OS="xUbuntu_20.04" ;; # works so far
        *) OS="" ;;
        esac
        readonly OS

        cd "${REPO_DIR}" || exit
        if [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]] &&
            [[ "$(uname -m)" == "x86_64" ]]; then
            echo "deb http://download.opensuse.org/repositories/home:/stig124:/nnn/${OS}/ /" | sudo tee /etc/apt/sources.list.d/home:stig124:nnn.list
            curl -fsSL "https://download.opensuse.org/repositories/home:stig124:nnn/${OS}/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_stig124_nnn.gpg > /dev/null
            sudo apt update
            sudo apt install -y nnn
        else
            echo "[INFO] prepare building nnn"
            sudo apt install -y libncursesw5-dev libreadline-dev

            echo "[INFO] build nnn"
            echo "REPO_DIR: ${REPO_DIR}"
            [[ ! -d nnn ]] && git clone https://github.com/jarun/nnn.git
            cd nnn
            git pull
            make -j "$(nproc)"
            sudo make install
        fi
    fi
fi
