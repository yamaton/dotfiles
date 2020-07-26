#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
readonly BASEDIR
CONFDIR="${HOME}/confs"

echo ""
echo "BASEDIR: ${BASEDIR}"
echo "CONFDIR: ${CONFDIR}"
echo ""

# configurations are in ~/confs
[[ ! -d "${CONFDIR}" ]] &&  mkdir "${CONFDIR}"


# update the system and install essential
if [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
    sudo apt update && sudo apt full-upgrade
    sudo apt install -y curl openssh-server
fi


# latest git (ubuntu only)
if [[ -x "$(command -v apt)" ]] && [[ "$(lsb_release -i -s)" == "Ubuntu" ]]; then
    echo ""
    echo "--------------------------"
    echo "       git from ppa"
    echo "--------------------------"
    sudo apt-add-repository ppa:git-core/ppa
    sudo apt update
    sudo apt install -y git
fi


# zsh
echo ""
echo "--------------------------"
echo "        zsh & more"
echo "--------------------------"
cd "${BASEDIR}" || exit
./_setup-zsh.sh -f


# colored man with less
echo ""
echo "--------------------------"
echo "        colored man"
echo "--------------------------"
[[ -e ~/.less_termcap ]] && mv ~/.less_termcap ~/.less_termcap.backup
ln -s "${BASEDIR}"/.less_termcap ~


# misc essential software
echo ""
echo "--------------------------"
echo "    software via apt"
echo "--------------------------"
cd "${BASEDIR}" || exit
./_setup-misc.sh


# custom installations
APPS=(tmux emacs neovim tldr cheatsheet ripgrep bat fd parallel nnn fzf broot delta)
for app in ${APPS[*]}; do
    echo ""
    echo "--------------------------"
    echo "        ${app}"
    echo "--------------------------"
    cd "${BASEDIR}" || exit
    "./_setup-${app}.sh" -f
done


echo ""
echo "--------------------------"
echo "        Cleaning up"
echo "--------------------------"
cd "${BASEDIR}" || exit
rm -rf ./_tmp
rm -f ./*.deb
rm -f ../*.deb

