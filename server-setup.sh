#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

echo "BASEDIR: ${BASEDIR}"
echo "CONFDIR: ${CONFDIR}"

# configurations are in ~/confs
[ ! -d "${CONFDIR}" ] &&  mkdir "${CONFDIR}"
cd "${CONFDIR}"

# update the system
sudo apt update && sudo apt full-upgrade

# zsh
sudo apt install -y zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone -b fix_non_git_folders https://github.com/Segaja/zsh-git-prompt.git
cp "${BASEDIR}"/.zshrc ~

# tmux and emacs setting
cp "${BASEDIR}"/.tmux.conf ~
cp "${BASEDIR}"/.emacs ~

# misc software
sudo apt install -y make cmake tmux emacs-nox htop ranger autojump meld wget curl gnupg2

# tldr
cd "${BASEDIR}"
./setup-tldr.sh "${CONFDIR}"
cd "${CONFDIR}"

# cht.sh
mkdir ~/bin
curl https://cht.sh/:cht.sh > ~/bin/cht.sh
chmod +x ~/bin/cht.sh

# ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
sudo dpkg -i ripgrep_0.9.0_amd64.deb

