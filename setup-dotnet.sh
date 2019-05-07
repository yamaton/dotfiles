#!/bin/bash

mkdir dotnet && cd dotnet
wget https://download.visualstudio.microsoft.com/download/pr/7e4b403c-34b3-4b3e-807c-d064a7857fe8/95c738f08e163f27867e38c602a433a1/dotnet-sdk-3.0.100-preview5-011568-linux-x64.tar.gz
tar xzf dotnet-sdk-3.0.100-preview5-011568-linux-x64.tar.gz
rm -f dotnet-sdk-3.0.100-preview5-011568-linux-x64.tar.gz
cd ..
mv dotnet ~
