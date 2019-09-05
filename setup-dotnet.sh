#!/bin/bash

if [ -d dotnet ]; then
    read -p "Remove existing dotnet directory? ([Y]/n)" RES
    if [ "$RES" == "n" ] || [ "$RES" == "N" ]; then
        exit 1
    else
        rm -rf dotnet
    fi
fi

mkdir dotnet && cd dotnet
URL="https://download.visualstudio.microsoft.com/download/pr/498b8b41-7626-435e-bea8-878c39ccbbf3/c8df08e881d1bcf9a49a9ff5367090cc/dotnet-sdk-3.0.100-preview9-014004-linux-x64.tar.gz"
wget $URL
FILENAME=$(basename $URL)
tar xzf $FILENAME
rm -f $FILENAME
cd ..
rm -rf ~/dotnet
mv dotnet ~
