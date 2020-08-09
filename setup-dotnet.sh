#!/usr/bin/env bash

if [[ -d dotnet ]]; then
    read -rp "Remove existing dotnet directory? ([Y]/n)" RES
    if [[ "$RES" == "n" ]] || [[ "$RES" == "N" ]]; then
        exit 1
    else
        rm -rf dotnet
    fi
fi

if [[ "$(lsb_release -i -s)" == "Ubuntu" ]] || [[ "$(lsb_release -i -s)" == "Pop" ]]; then
    # https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
    OS_VERSION="$(lsb_release -r -s)"
    readonly OS_VERSION
    wget -q "https://packages.microsoft.com/config/ubuntu/$OS_VERSION/packages-microsoft-prod.deb"
    sudo dpkg -i packages-microsoft-prod.deb
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-3.1
    rm packages-microsoft-prod.deb

elif [[ "$(lsb_release -sc)" == "buster" ]]; then
    # https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-debian10
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
    sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
    wget -q https://packages.microsoft.com/config/debian/10/prod.list
    sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
    sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
    sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
    sudo apt-get update
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-3.1
fi
