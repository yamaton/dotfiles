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
sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
cd "${CONFDIR}"
git clone https://github.com/tldr-pages/tldr-cpp-client.git tldr-cpp-client
cd tldr-cpp-client
./deps.sh
make
sudo make install
mv "${CONFDIR}"/tldr-cpp-client/autocomplete/complete.zsh ~/.tldr.complete
echo "source ~/.tldr.complete" >> ~/.zshrc

# ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
sudo dpkg -i ripgrep_0.8.1_amd64.deb
