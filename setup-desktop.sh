#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
echo "BASEDIR: ${BASEDIR}"


# vscode
echo "-------------------------"
echo "   vscode"
echo "-------------------------"
if [ ! -x "$(command -v code)" ]; then
    cd "${BASEDIR}"
    ./_setup-vscode.sh
    cp ./vscode/settings.json ~/.config/Code/User/settings.json
else
    echo "[INFO] skipping; vscode is already available"
fi

# misc software
echo "-------------------------"
echo "   terminator"
echo "-------------------------"
sudo apt install -y terminator --no-install-recommends


echo "-------------------------"
echo "   meld"
echo "-------------------------"
sudo apt install -y meld --no-install-recommends


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