#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
APPS=("$(cat "${BASEDIR}/misc_apps.txt")")
readonly BASEDIR
readonly APPS

if [[ "$(uname -s)" == "Darwin" ]]; then
    for app in ${APPS[*]}; do
        brew install "$(printf "%s" "$app")"
    done
elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
    for app in ${APPS[*]}; do
        echo ""
        echo "---------------"
        echo " $app"
        echo "---------------"
        sudo apt install -y "$(printf "%s" "$app")" --no-install-recommends
    done
fi
