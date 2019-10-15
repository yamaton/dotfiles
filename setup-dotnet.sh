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
URL="https://download.visualstudio.microsoft.com/download/pr/a3cc3d8a-226d-4306-a61b-a5446fdb72ef/604e029047aec0229545e8c397a14ddb/dotnet-sdk-3.1.100-preview1-014459-linux-x64.tar.gz"
wget $URL
FILENAME=$(basename $URL)
tar xzf "$FILENAME"
rm -f "$FILENAME"
cd ..
rm -rf ~/dotnet
mv dotnet ~
