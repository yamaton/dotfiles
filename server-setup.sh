#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

my_install () {
    app="$(command -v $1)"
    [ ! -x $app ] &&  sudo apt install -y $1
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

# git
echo ""
echo "--------------------------"
echo "         git"
echo "---------------------------"
my_install git


# zsh
echo ""
echo "--------------------------"
echo "         zsh & more"
echo "---------------------------"
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
cp "${BASEDIR}"/.zshrc ~



# tmux and emacs setting
echo ""
echo "--------------------------"
echo "       tmux"
echo "---------------------------"
my_install tmux
cp "${BASEDIR}"/.tmux.conf ~

echo ""
echo "--------------------------"
echo "       emacs"
echo "---------------------------"
[ ! -x "$(command -v emacs)" ] &&  sudo apt install -y emacs-nox
cp "${BASEDIR}"/.emacs ~

# misc software
echo ""
echo "--------------------------"
echo "       misc software"
echo "---------------------------"
apps="make cmake htop ranger autojump wget curl gnupg2"
for f in $apps
do
    my_install $f
done


# tldr
echo ""
echo "--------------------------"
echo "         tldr client"
echo "---------------------------"
cd "${BASEDIR}"
sudo ./setup-tldr.sh "${CONFDIR}"
cd "${CONFDIR}"

# cht.sh
echo ""
echo "--------------------------"
echo "         cht.sh"
echo "---------------------------"
[ ! -d ~/bin ] &&  mkdir ~/bin
curl https://cht.sh/:cht.sh > ~/bin/cht.sh
chmod +x ~/bin/cht.sh

# ripgrep
echo ""
echo "--------------------------"
echo "         Ripgrep"
echo "---------------------------"
if [ ! -x "$(command -v rg)" ]; then
    wget https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
    sudo dpkg -i ripgrep_0.9.0_amd64.deb
fi