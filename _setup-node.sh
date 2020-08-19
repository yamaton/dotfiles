#!/usr/bin/env bash

readonly cmd=node
version="$(curl --silent https://formulae.brew.sh/api/formula/${cmd}.json | jq '.versions.stable' | tr -d \")"
readonly version


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
    tar xvf "$file"
    dir="${file%.*.*}"
    rm -rf "$HOME"/bin/node
    mv "$dir" "$HOME"/bin/node
    rm -f ./"$file"
fi

