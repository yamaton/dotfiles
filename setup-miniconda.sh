#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
readonly CONFDIR="${HOME}/confs"

cd "$CONFDIR" || exit
if [[ "$(uname -s)" == "Darwin" ]]; then
    readonly OS="MacOSX"
else
    readonly OS="Linux"
fi

if [[ "$(uname -m)" == "x86_64" ]]; then
    [[ -e ~/.condarc ]] && mv ~/.condarc ~/.condarc.backup
    ln -s "${BASEDIR}/.condarc" ~

    readonly URI="https://repo.anaconda.com/miniconda/Miniconda3-latest-${OS}-x86_64.sh"
    wget -N "$URI"
    chmod +x ./Miniconda3-latest-${OS}-x86_64.sh
    ./Miniconda3-latest-${OS}-x86_64.sh

    # shellcheck source=/dev/null
    source ~/miniconda3/etc/profile.d/conda.sh
    conda update --all
    if [[ -x "$(command -v nvidia-smi)" ]]; then
        conda create -n tf tensorflow-gpu opencv
    else
        conda create -n tf tensorflow opencv
    fi
    conda activate tf
    conda config --add channels conda-forge --env
else
    echo "Miniconda does not seem to support $(uname -m). Exiting."
fi
