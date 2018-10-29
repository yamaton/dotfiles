#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

cd "$CONFDIR"
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
. ~/miniconda3/etc/profile.d/conda.sh
cp "${BASEDIR}/.condarc" ~
conda update --all
conda create -n tf -c conda-forge tensorflow opencv=3.3.0
conda activate tf
conda config --add channels conda-forge --env
