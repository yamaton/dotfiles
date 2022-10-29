#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly CMD=rga
readonly NAME="ripgrep-all"

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${NAME}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | head -1 | cut -d ' ' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v $CMD)" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        case "$(uname -m)" in
            "x86_64")  readonly file="ripgrep_all-v${VERSION}-x86_64-unknown-linux-musl.tar.gz"    ;;
            "armv7l")  readonly file="ripgrep_all-v${VERSION}-arm-unknown-linux-gnueabihf.tar.gz"  ;;
        esac
        if [[ -z "${file+x}" ]]; then
            echo "Unsupported architecture? $(uname -s)"
            echo "    Exiting..."
            exit 0
        fi
        uri="https://github.com/phiresky/ripgrep-all/releases/download/v${VERSION}/${file}"
        wget -N "$uri"
        filename="$(basename "$uri")"
        dir="${filename%.tar.gz}"
        tar xvf ./"$filename"
        cp -f "${dir}/rga" ~/.local/bin/
        cp -f "${dir}/rga-preproc" ~/.local/bin/
        rm -f ./"$filename"
        rm -rf "${dir}"
    fi
fi
