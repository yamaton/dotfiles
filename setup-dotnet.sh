#!/usr/bin/env bash

if [ $(lsb_release -sc) == "bionic" ]; then
    # https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1804
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install dotnet-sdk-3.1
    rm packages-microsoft-prod.deb

elif [ $(lsb_release -sc) == "buster" ]; then
    # https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-debian10
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
    sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
    wget -q https://packages.microsoft.com/config/debian/10/prod.list
    sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
    sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
    sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install dotnet-sdk-3.1
fi
