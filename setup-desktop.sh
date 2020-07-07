#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
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
[[ -x "$(command -v apt)" ]] && sudo apt install -y terminator --no-install-recommends


echo "-------------------------"
echo "   meld"
echo "-------------------------"
[[ -x "$(command -v apt)" ]] && sudo apt install -y meld --no-install-recommends


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


echo "-------------------------"
echo "   Joplin"
echo "-------------------------"
cd "${BASEDIR}" || exit
./_setup-joplin.sh -f



