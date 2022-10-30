#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly NAME=zoxide

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $NAME)" ]]; then
    CURRENT="$("$NAME" --version | cut -d ' ' -f2 | cut -c 2-)"
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
            "x86_64")  readonly FILE="${NAME}-${VERSION}-x86_64-unknown-linux-musl.tar.gz" ;;
            "armv7l")  readonly FILE="${NAME}-${VERSION}-armv7-unknown-linux-musleabihf.tar.gz" ;;
            "aarch64") readonly FILE="${NAME}-${VERSION}-aarch64-unknown-linux-musl.tar.gz" ;;
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

        readonly URI="https://github.com/ajeetdsouza/zoxide/releases/download/v${VERSION}/${FILE}"
        wget -N "$URI"
        readonly DIRNAME="${FILE%.*.*}"
        mkdir -p "$DIRNAME"
        tar -xvf "$FILE" --directory "$DIRNAME"
        rm -f "$FILE"
        mkdir -p ~/.local/bin
        mv "${DIRNAME}/${NAME}" ~/.local/bin/

        # save man files
        mkdir -p ~/.local/share/man/man1
        mv "${DIRNAME}"/man/man1/*.1 ~/.local/share/man/man1
        mandb ~/.local/share/man
        rm -rf "$DIRNAME"
    fi
fi
