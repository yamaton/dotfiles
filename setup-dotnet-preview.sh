#!/usr/bin/env bash

if [[ "$USER" != "root" ]]; then
    echo "Run with sudo. Exiting..."
    exit 1
fi

readonly MYDIR="$HOME"/dotnet_install
readonly FILE="install-dotnet-preview.sh"

sudo rm -rf "$MYDIR"
mkdir -p "$MYDIR" && cd "$MYDIR" || exit
curl -H 'Cache-Control: no-cache' -L https://aka.ms/install-dotnet-preview -o "$FILE"
sed -i 's/*"Ubuntu 20.04"*/*"Ubuntu 20.04"* | *"Pop!_OS 20.04"*/' "$FILE"
sudo bash "$FILE"
cd ..
sudo rm -rf "$MYDIR"
