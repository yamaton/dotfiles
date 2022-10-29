#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
echo "BASEDIR: ${BASEDIR}"


# vscode
echo "-------------------------"
echo "   vscode"
echo "-------------------------"
cd "${BASEDIR}" || exit
./_setup-vscode.sh


# misc software
echo "-------------------------"
echo "   terminator"
echo "-------------------------"
[[ "$(command -v apt)" ]] && sudo apt install -y terminator --no-install-recommends


echo "-------------------------"
echo "   meld"
echo "-------------------------"
[[ "$(command -v apt)" ]] && sudo apt install -y meld --no-install-recommends


# fonts-firacode
echo "-------------------------"
echo "   Fira code fonts"
echo "-------------------------"
cd "${BASEDIR}" || exit
./_setup-firacode.sh


echo "-------------------------"
echo "   Misc fonts"
echo "-------------------------"
cd "${BASEDIR}" || exit
./_setup-fonts.sh


apps=("joplin" "kitty")
for app in ${apps[*]}; do
    echo "-------------------------"
    echo "   $app"
    echo "-------------------------"
    cd "${BASEDIR}" || exit
    "./_setup-$app.sh" -f
done

