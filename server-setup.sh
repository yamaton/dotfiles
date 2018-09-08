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
my_install zsh

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
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup
fi
cp "${BASEDIR}"/.zshrc ~



# tmux and emacs setting
echo ""
echo "--------------------------"
echo "        tmux"
echo "--------------------------"
my_install tmux
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.backup
fi
cp "${BASEDIR}"/.tmux.conf ~

echo ""
echo "--------------------------"
echo "        emacs"
echo "--------------------------"
[ ! -x "$(command -v emacs)" ] &&  sudo apt install -y emacs-nox
if [ -f ~/.emacs ]; then
    mv ~/.emacs ~/.emacs.backup
fi
cp "${BASEDIR}"/.emacs ~


# misc software
echo ""
echo "--------------------------"
echo "        misc software"
echo "--------------------------"
APPS="cmake htop ranger autojump wget curl gnupg2 source-highlight jq csvtool"
for f in "${APPS}"
do
    my_install $f
done


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


# ripgrep
echo ""
echo "--------------------------"
echo "        Ripgrep"
echo "--------------------------"
cd "${BASEDIR}"
sudo ./_setup-ripgrep.sh
