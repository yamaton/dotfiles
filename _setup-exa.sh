#!/bin/bash

if [ "$1" = "-f" ] || [ ! -x "$(command -v exa)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install exa
    elif [ "$(uname -m)" == "x86_64" ] && [ -x $(command -v cargo) ] ; then
	cargo install exa
    else
	echo "cargo is missing. Exiting without installing exa..."
    fi
fi
