#!/usr/bin/env bash

$CMD=exa

if [ "$1" = "-f" ] || [ ! -x "$(command -v exa)" ]; then
    if [ "$(uname -s)" == "Darwin" ]; then
        brew install "$CMD"
    elif [ "$(uname -m)" == "x86_64" ] && [ -x "$(command -v cargo)" ] ; then
	cargo install "$CMD"
    else
	echo "cargo is missing. Exiting without installing exa..."
    fi
fi
