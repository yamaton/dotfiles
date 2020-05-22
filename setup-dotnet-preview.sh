#!/usr/bin/env bash

MYDIR=$HOME/dotnet_install

mkdir -p "$MYDIR" && cd "$MYDIR"
curl -H 'Cache-Control: no-cache' -L https://aka.ms/install-dotnet-preview -o install-dotnet-preview.sh
sed -i 's/*"Ubuntu 20.04"*/*"Ubuntu 20.04"* | *"Pop!_OS 20.04"*/' install-dotnet-preview.sh
sudo bash install-dotnet-preview.sh
cd ..
rm -rf $MYDIR
