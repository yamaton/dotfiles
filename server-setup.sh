#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

my_install () {
    app="$(command -v $1)"
    [ ! -x "$app" ] && sudo apt install -y "$1"
}

echo ""
echo "BASEDIR: ${BASEDIR}"
echo "CONFDIR: ${CONFDIR}"
echo ""

# configurations are in ~/confs
[ ! -d "${CONFDIR}" ] &&  mkdir "${CONFDIR}"
cd "${CONFDIR}"

# update the system
sudo apt update && sudo apt full-upgrade


# zsh
echo ""
echo "--------------------------"
echo "        zsh & more"
echo "--------------------------"
sudo apt install -y zsh

if [ -d zsh-syntax-highlighting ]; then
    cd zsh-syntax-highlighting
    git pull
    cd ..
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi

if [ -d zsh-git-prompt ]; then
    cd zsh-git-prompt
    git pull
    cd ..
else
    git clone https://github.com/starcraftman/zsh-git-prompt.git
fi
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
cp "${BASEDIR}"/.zshrc ~


# colored man with less
echo ""
echo "--------------------------"
echo "        colored man"
echo "--------------------------"
[ -f ~/.less_termcap ] && mv ~/.less_termcap ~/.less_termcap.backup
cp "${BASEDIR}"/.less_termcap ~


# tmux and emacs setting
echo ""
echo "--------------------------"
echo "        tmux"
echo "--------------------------"
sudo apt install -y tmux
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
cp "${BASEDIR}"/.tmux.conf ~
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


echo ""
echo "--------------------------"
echo "        emacs"
echo "--------------------------"
[ ! -x "$(command -v emacs)" ] &&  sudo apt install -y emacs-nox
[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.backup
cp "${BASEDIR}"/.emacs ~


# misc software
echo ""
echo "--------------------------"
echo "        misc software"
echo "--------------------------"
APPS="cmake htop autojump wget curl gnupg2 source-highlight jq csvtool python"
sudo apt install -y "${APPS}"


# tldr
echo ""
echo "--------------------------"
echo "        tldr client"
echo "--------------------------"
cd "${BASEDIR}"
sudo ./_setup-tldr.sh "${CONFDIR}"


# cht.sh
echo ""
echo "--------------------------"
echo "        cht.sh"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-cheetsheet.sh


# ripgrep ---better grep---
echo ""
echo "--------------------------"
echo "        ripgrep"
echo "--------------------------"
cd "${BASEDIR}"
sudo ./_setup-ripgrep.sh


# fd ---better find---
echo ""
echo "--------------------------"
echo "        fd"
echo "--------------------------"
cd "${BASEDIR}"
sudo ./_setup-fd.sh


# nnn
echo ""
echo "--------------------------"
echo "        nnn"
echo "--------------------------"
sudo apt install -y libncursesw5-dev
sudo ./_setup-nnn.sh "${CONFDIR}"

