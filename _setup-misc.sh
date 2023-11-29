#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Get the Bash version
bash_version=$(bash --version | head -n1 | cut -d " " -f4 | cut -d "(" -f1)

# Extract major version
major_version=${bash_version%%.*}

# Check if the major version is less than or equal to 3
if [ "$major_version" -le 3 ]; then
    echo "Bash version 3 or lower detected. Exiting."
    exit 1
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
