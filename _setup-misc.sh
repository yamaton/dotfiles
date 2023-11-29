#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readarray -t APPS < "${BASEDIR}/misc_apps.txt"
readonly BASEDIR
readonly APPS

if [[ "$(uname -s)" == "Darwin" ]]; then
    for app in "${APPS[@]}"; do
        brew install "$(printf "%s" "$app")"
    done
elif [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
    for app in "${APPS[@]}"; do
        echo ""
        echo "---------------"
        echo " $app"
        echo "---------------"
        sudo apt install -y "$(printf "%s" "$app")" --no-install-recommends
    done
fi
