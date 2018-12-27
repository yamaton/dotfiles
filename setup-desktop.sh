#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
echo "BASEDIR: ${BASEDIR}"


# vscode
echo "-------------------------"
echo "   vscode"
echo "-------------------------"
cd "${BASEDIR}"
./_setup-vscode.sh


# misc software
echo "-------------------------"
echo "   terminator"
echo "-------------------------"
[ -x $(command -v apt) ] && sudo apt install -y terminator --no-install-recommends


echo "-------------------------"
echo "   meld"
echo "-------------------------"
[ -x $(command -v apt) ] && sudo apt install -y meld --no-install-recommends


# fonts-firacode
echo "-------------------------"
echo "   Fira code fonts"
echo "-------------------------"
cd "${BASEDIR}"
./_setup-firacode.sh


echo "-------------------------"
echo "   Source Code Pro fonts"
echo "   (just downloading..)"
echo "-------------------------"
cd "${BASEDIR}"
./_download_fonts.sh