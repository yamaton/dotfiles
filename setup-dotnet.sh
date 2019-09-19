#!/usr/bin/env bash

echo "-----------------------------------------------------------"
echo "[NOTE] dotnet fsi is broken since 3.0.100-preview8 to -rc1"
echo ""
echo "> Failed to install ctrl-c handler - Ctrl-C handling will not be available. Error was:"
echo "	Could not load file or assembly 'Mono.Posix, Version=2.0.0.0, Culture=neutral,"
echo "  PublicKeyToken=0738eb9f132ed756'. The system cannot find the file specified."
echo ""
echo "  See https://github.com/dotnet/fsharp/pull/7495"
echo "-----------------------------------------------------------"
echo ""

if [ -d dotnet ]; then
    read -r -p "Remove existing dotnet directory? ([Y]/n)" RES
    if [ "$RES" == "n" ] || [ "$RES" == "N" ]; then
        exit 1
    else
        rm -rf dotnet
    fi
fi

mkdir dotnet && cd dotnet
URL="https://download.visualstudio.microsoft.com/download/pr/c624c5d6-0e9c-4dd9-9506-6b197ef44dc8/ad61b332f3abcc7dec3a49434e4766e1/dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz"
wget $URL
FILENAME=$(basename $URL)
tar xzf "$FILENAME"
rm -f "$FILENAME"
cd ..
rm -rf ~/dotnet
mv dotnet ~
