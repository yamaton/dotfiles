#!/usr/bin/env bash

readonly NAME=topgrade

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $NAME)" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${NAME} ${CURRENT}"
    else
        echo "${NAME} ${VERSION} is available: (current ${NAME} ${CURRENT})"
        read -rp "Upgrade to ${NAME} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${NAME})" ]] || [[ "$confirm" == [yY] ]]; then
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

        readonly URL="https://github.com/r-darwish/topgrade/releases/download/v${VERSION}/${FILE}"

        wget -N "$URL"
        tar xvf "$FILE"
        rm -f "$FILE"
        mv -f ./topgrade "${HOME}/.local/bin/"

        readonly MANURL="https://raw.githubusercontent.com/r-darwish/topgrade/v${VERSION}/topgrade.8"
        mkdir -p ~/.local/share/man/man8
        wget -N "$MANURL" --output-document ~/.local/share/man/man8/"$(basename "$MANURL")"
        mandb ~/.local/share/man
    fi
fi
