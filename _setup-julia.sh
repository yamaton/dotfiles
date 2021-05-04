#!/usr/bin/env bash

readonly CMD=julia

VERSION="$(curl --silent https://formulae.brew.sh/api/cask/${CMD}.json | jq '.version' | tr -d \")"
readonly VERSION

if [[ -x "$(command -v $CMD)" ]]; then
    CURRENT="$("$CMD" --version | cut -d ' ' -f3)"
    readonly CURRENT
    if [[ "$VERSION" == "$CURRENT" ]]; then
        echo "... already the latest: ${CMD} ${CURRENT}"
    else
        echo "${CMD} ${VERSION} is available: (current ${CMD} ${CURRENT})"
        read -rp "Upgrade to ${CMD} ${VERSION}? (y/N): " confirm
    fi
fi

if [[ "$1" == "-f" ]] || [[ ! -x "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew cask install "$CMD"
    elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "x86_64" ]]; then
        readonly URI="https://julialang-s3.julialang.org/bin/musl/x64/${VERSION%.*}/julia-${VERSION}-musl-x86_64.tar.gz"
        cd ~/bin || exit
        wget -N "$URI"
        FILE="$(basename "$URI")"
        readonly FILE
        tar xvf ./"$FILE"
        rm -f ./"$FILE"
        ln -sf "${HOME}/bin/julia-${VERSION}/bin/julia" "${HOME}/bin/julia"

        mkdir -p ~/.local/share/man/man1
        cp -r "${HOME}"/bin/julia-"${VERSION}"/share/man/man1/*.1 ~/.local/share/man/man1
        mandb ~/.local/share/man
    fi
fi
