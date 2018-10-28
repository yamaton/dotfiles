#!/bin/bash

if [ ! -x "$(command -v gotop)" ]; then
    if [ "$(uname -m)" == "x86_64" ]; then
        wget https://github.com/cjbassi/gotop/releases/download/1.5.0/gotop_1.5.0_linux_amd64.tgz
        tar xzf gotop_1.5.0_linux_amd64.tgz
    fi
    if [ "$(uname -m)" == "armv7l" ]; then
        wget https://github.com/cjbassi/gotop/releases/download/1.5.0/gotop_1.5.0_linux_arm7.tgz
        tar xzf gotop_1.5.0_linux_arm7.tgz
    fi

    [ ! -d ~/bin ] &&  mkdir ~/bin
    mv gotop ~/bin
fi