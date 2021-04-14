#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR

if [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install -y fish

    readonly fishconfig=~/.config/fish/config.fish
    [[ -f $fishconfig ]] && mv $fishconfig $fishconfig.backup
    ln -sf "${BASEDIR}/.config/fish/config.fish" $fishconfig

    readonly fishprompt=~/.config/fish/functions/fish_prompt.fish
    [[ -f $fishprompt ]] && mv $fishprompt $fishprompt.backup
    ln -sf "${BASEDIR}/.config/fish/functions/fish_prompt.fish" $fishprompt
fi
