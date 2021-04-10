#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR

if [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install -y fish
    [[ -d ~/.config/fish ]] && mv ~/.config/fish ~/.config/fish.backup
    ln -sf "${BASEDIR}/.config/fish" ~/.config/fish
fi
