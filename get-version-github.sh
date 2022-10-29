#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Check latest release version in GitHub
#
# Sample usage:
#   $ ./get-version-github.sh BurntSushi/ripgrep
#
# Returns version like 12.1.1 as standard output
#

owner_repo="$1"
url="https://api.github.com/repos/${owner_repo}/releases"
version="$(curl --silent "$url" | jq -M '.[0].tag_name' | tr -d \" | tr '[:upper:]' '[:lower:]')"
if [[ $(echo "$version" | cut -c 1) == "v" ]]; then
    echo "$version" | cut -c 2-
else
    echo "$version"
fi
