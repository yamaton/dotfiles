#!/bin/bash

rm -rf dotnet && mkdir dotnet && cd dotnet
wget "https://download.visualstudio.microsoft.com/download/pr/c624c5d6-0e9c-4dd9-9506-6b197ef44dc8/ad61b332f3abcc7dec3a49434e4766e1/dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz"
tar xzf "dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz"
rm -f "dotnet-sdk-3.0.100-preview7-012821-linux-x64.tar.gz"
cd ..
rm -rf ~/dotnet
mv dotnet ~
