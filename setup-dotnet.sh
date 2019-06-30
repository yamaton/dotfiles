#!/bin/bash

mkdir dotnet && cd dotnet
wget https://download.visualstudio.microsoft.com/download/pr/72ce4d40-9063-4a2e-a962-0bf2574f75d1/5463bb92cff4f9c76935838d1efbc757/dotnet-sdk-3.0.100-preview6-012264-linux-x64.tar.gz
tar xzf dotnet-sdk-3.0.100-preview6-012264-linux-x64.tar.gz 
rm -f dotnet-sdk-3.0.100-preview6-012264-linux-x64.tar.gz 
cd ..
rm -rf ~/dotnet
mv dotnet ~
