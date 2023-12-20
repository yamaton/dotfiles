#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly NAME=topgrade

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq -r '.versions.stable')"
readonly VERSION

if [[ "$(command -v $NAME)" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${NAME} ${CURRENT}"
    else
        echo "${NAME} ${VERSION} is available: (current ${NAME} ${CURRENT})"
        read -rp "Upgrade to ${NAME} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v ${NAME})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$NAME"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        case "$(uname -m)" in
            "x86_64")  readonly FILE="topgrade-v${VERSION}-x86_64-unknown-linux-musl.tar.gz" ;;
            "armv7l")  readonly FILE="topgrade-v${VERSION}-armv7-unknown-linux-gnueabihf.tar.gz" ;;
            "aarch64") readonly FILE="topgrade-v${VERSION}-aarch64-unknown-linux-gnu.tar.gz" ;;
        esac

        if [[ -z "${FILE+x}" ]]; then
            if [[ ! "$(command -v cargo)" ]]; then
                read -rp "Install cargo and rust? (y/N): " confirm
                if [[ "$confirm" == [yY] ]]; then
                    BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
                    readonly BASEDIR
                    source "${BASEDIR}/setup-rust-and-cargo.sh"
                else
                    echo "Exit without installing ${NAME}"
                    exit 0
                fi
            fi
            cargo install "$NAME"
            exit 0
        fi

        readonly URL="https://github.com/topgrade-rs/topgrade/releases/download/v${VERSION}/${FILE}"

        wget -N "$URL"
        tar -xvf "$FILE"
        rm -f "$FILE"
        mv -f ./topgrade "${HOME}/.local/bin/"

        cp -f "$BASEDIR"/.config/topgrade.toml ~/.config/topgrade.toml

        # check if nala is installed in debian systems
        if [[ "$(command -v apt)" ]] && [[ ! "$(command -v nala)" ]]; then
            echo "--------------------------------------------"
            echo "Installing nala"
            echo "--------------------------------------------"
            wget https://gitlab.com/volian/volian-archive/uploads/b20bd8237a9b20f5a82f461ed0704ad4/volian-archive-keyring_0.1.0_all.deb
            wget https://gitlab.com/volian/volian-archive/uploads/d6b3a118de5384a0be2462905f7e4301/volian-archive-nala_0.1.0_all.deb
            sudo apt install ./volian-archive-keyring_0.1.0_all.deb
            sudo apt install ./volian-archive-nala_0.1.0_all.deb
            sudo apt update && sudo apt install nala
        fi
    fi
fi
