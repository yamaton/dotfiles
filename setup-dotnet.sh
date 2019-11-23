#!/usr/bin/env bash

if [ -d dotnet ]; then
    read -r -p "Remove existing dotnet directory? ([Y]/n)" RES
    if [ "$RES" == "n" ] || [ "$RES" == "N" ]; then
        exit 1
    else
        rm -rf dotnet
    fi
fi

mkdir dotnet && cd dotnet
URL="https://download.visualstudio.microsoft.com/download/pr/941853c3-98c6-44ff-b11f-3892e4f91814/14e8f22c7a1d95dd6fe9a53296d19073/dotnet-sdk-3.1.100-preview3-014645-linux-x64.tar.gz"
wget $URL
FILENAME=$(basename $URL)
tar xzf "$FILENAME"
rm -f "$FILENAME"
cd ..
rm -rf ~/dotnet
mv dotnet ~
