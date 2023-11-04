#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi


## Sanity checks
if [[ $USER != "jovyan" ]]; then
    echo "This script should be run in a JupyterHub environment"
    exit 1
fi

if [[ ! "$(command -v rg)" ]]; then
    echo "[error] ripgrep (rg) is missing."
    exit 1
fi

if [[ ! "$(command -v yq)" ]]; then
    echo "[error] yq is missing."
    exit 1
fi

if [[ ! "$(command -v mamba)" ]]; then
    echo "[error] mamba is missing."
    exit 1
fi

if [[ ! "$(command -v condax)" ]]; then
    echo "[error] condax is missing."
    exit 1
fi


mkdir -p dumpdump
pushd dumpdump

# Save jupyter image name
echo "$JUPYTER_IMAGE_SPEC" | cut -d ':' -f 1 > name.txt

# Export mamba/conda packages
mamba env export -n notebook -f env_orig.yml

# Remove bash-kernel here as it's under pip
cat  <<EOF > blacklist.txt
bash-kernel
myextension
jupyter-archive
jlab-enhanced-launcher
jupyter-fs
jupyterlab-copy-relative-path
jupyterlab-spreadsheet-editor
jupyterlab-night
jupyterlab_miami_nights
theme-darcula
jupyterlab-qzv
jupyter-remote-desktop-proxy
jupyterlab-legos-ui
jupyterlab-darkside-ui
EOF

# 1. Limit fields to channels and dependencies
# 2. Remove blacklisted packages
# 3. Add bash-kernel to the conda dependencies
# [NOTE] bash_kernel 0.9.1 is unavailable on conda-forge as of 2023-08-22
yq '{channels: .channels, dependencies: .dependencies}' < env_orig.yml \
  | rg -v -f blacklist.txt \
  | yq '.dependencies = ["bash_kernel==0.9.0"] + .dependencies' > env.yml

# Export condax package info
condax export

# Copy pipx package info
cp -f ~/binder/_tools_pipx.txt pipx.txt

# Copy apt package info
cp -f ~/binder/apt.txt .

# Archive all the files
tar -czf "dump.tar.gz" env.yml name.txt pipx.txt apt.txt condax_exported/

popd

mv dumpdump/dump.tar.gz .
