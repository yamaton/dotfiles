#!/bin/bash

if [ "$1" = "-f" ] || [ ! -x "$(command -v xsv)" ]; then
    if [ "$(uname -m)" == "x86_64" ]; then
        wget https://github.com/BurntSushi/xsv/releases/download/0.13.0/xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
        tar xzf xsv-0.13.0-x86_64-unknown-linux-musl.tar.gz
        [ ! -d ~/bin ] &&  mkdir ~/bin
        mv xsv ~/bin
    fi
fi
