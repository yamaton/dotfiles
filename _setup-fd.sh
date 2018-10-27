#!/bin/bash

if [ ! -x "$(command -v fd)" ]; then
    if [ "$(uname -m)" == "x86_64" ]; then
        wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd-musl_7.2.0_amd64.deb
        sudo apt install ./fd-musl_7.2.0_amd64.deb
    fi
    if [ "$(uname -m)" == "x86_64" ]; then
        wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd-v7.2.0-arm-unknown-linux-gnueabihf.tar.gz
        tar xzf fd-v7.2.0-arm-unknown-linux-gnueabihf.tar.gz
        cp fd-v7.2.0-arm-unknown-linux-gnueabihf/fd ~/bin
    fi
fi