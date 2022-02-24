#!/usr/bin/env bash

readonly CMD=syncthing

VERSION="$(curl --silent https://formulae.brew.sh/api/formula/${CMD}.json | jq '.versions.stable' | tr -d \")"
readonly VERSION

if [[ "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d' ' -f2 | cut -d'v' -f2)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        case "$(uname -m)" in
            "x86_64")   readonly ARCH="amd64" ;;
            "armv7l")   readonly ARCH="arm"   ;;
            "aarch64")  readonly ARCH="arm64" ;;
        esac
        readonly URI="https://github.com/syncthing/syncthing/releases/download/v${VERSION}/syncthing-linux-${ARCH}-v${VERSION}.tar.gz"
        wget -N "$URI"
        readonly FILE="$(basename "$URI")"
        readonly DIR="${FILE%.tar.gz}"
        tar -xf ./"$FILE"
        rm "$FILE"
        mkdir -p ~/.local/bin
        rm -rf ~/.local/bin/syncthing*
        mv -f ./"$DIR" ~/.local/bin/"$DIR"
        [[ -f ~/.local/bin/"$CMD" ]] && mv -f "~/.local/bin/${CMD}" "~/.local/bin/${CMD}.backup"
        ln -sf "$HOME/.local/bin/$DIR/$CMD" ~/.local/bin
    fi
fi
