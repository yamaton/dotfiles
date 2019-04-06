#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

cd "$CONFDIR"
if [ $(uname -s) == "Darwin" ]; then
    OS="MacOSX"
else
    OS="Linux"
fi

if [ $(uname -m) == "x86_64" ]; then
    URI="https://repo.anaconda.com/miniconda/Miniconda3-latest-${OS}-x86_64.sh"
    wget -N "$URI"
    chmod +x ./Miniconda3-latest-${OS}-x86_64.sh
    ./Miniconda3-latest-${OS}-x86_64.sh

    source ~/miniconda3/etc/profile.d/conda.sh
    cp "${BASEDIR}/.condarc" ~

    conda update --all
    conda create -n tf -c conda-forge tensorflow opencv=4.0.1
    conda activate tf
    conda config --add channels conda-forge --env
else
    echo "Miniconda does not seem to support $(uname -m). Exiting."
fi
