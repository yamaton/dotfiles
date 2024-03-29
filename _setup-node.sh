#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

readonly cmd=node
version="$(curl --silent https://formulae.brew.sh/api/formula/${cmd}.json | jq -r '.versions.stable')"
readonly version

if [[ "$(command -v $CMD)" ]]; then
    current="$("$cmd" --version | cut -c 2-)"
    readonly CURRENT
    confirm=N
    if [[ "$VERSION" == "$CURRENT" ]]; then        echo "... already the latest: ${cmd} ${current}"
    else
        echo "${cmd} ${version} is available: (current ${cmd} ${current})"
        read -rp "Upgrade to ${cmd} ${version}? (y/N): " confirm
    fi
fi


if [[ "${1-}" == "-f" ]] || [[ ! "$(command -v ${CMD})" ]] || [[ "$confirm" == [yY] ]]; then

    if [[ "$(uname -s)" == "Darwin" ]]; then
        brew install "$cmd"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            arch="x64"
        elif [[ "$(uname -m)" == "armv7l" ]]; then
            arch="armv7l"
        else
            echo "This script does not support $(uname -m). Just existing without installation..."
            exit
        fi
        uri="https://nodejs.org/dist/v${version}/node-v${version}-linux-${arch}.tar.xz"
        wget -N "$uri"
        file="$(basename "$uri")"
        readonly file
        tar -xvf "$file"
        dir="${file%.*.*}"
        rm -rf "$HOME"/.local/bin/node
        mv "$dir" "$HOME"/.local/bin/node
        rm -f ./"$file"
    fi
fi
