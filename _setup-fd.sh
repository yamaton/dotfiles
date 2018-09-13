#!/bin/bash

if [ ! -x "$(command -v fd)" ]; then
    wget https://github.com/sharkdp/fd/releases/download/v7.1.0/fd-musl_7.1.0_amd64.deb
    sudo apt install ./fd-musl_7.1.0_amd64.deb
fi