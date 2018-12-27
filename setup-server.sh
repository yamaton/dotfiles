#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

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
cd "${BASEDIR}"
./_setup-zsh.sh


# colored man with less
echo ""
echo "--------------------------"
echo "        colored man"
echo "--------------------------"
[ -f ~/.less_termcap ] && mv ~/.less_termcap ~/.less_termcap.backup
cp "${BASEDIR}"/.less_termcap ~


# tmux
echo ""
echo "--------------------------"
echo "        tmux"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-tmux.sh


# emacs
echo ""
echo "--------------------------"
echo "        emacs"
echo "--------------------------"
./_setup-emacs.sh


# neovim
echo ""
echo "--------------------------"
echo "        neovim"
echo "--------------------------"
./_setup-neovim.sh


# misc software
echo ""
echo "--------------------------"
echo "        misc software"
echo "--------------------------"
./_setup-misc.sh


# tldr
echo ""
echo "--------------------------"
echo "        tldr client"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-tldr.sh


# cht.sh
echo ""
echo "--------------------------"
echo "        cht.sh"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-cheatsheet.sh


# ripgrep ---better grep---
echo ""
echo "--------------------------"
echo "        ripgrep"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-ripgrep.sh


# fd ---better find---
echo ""
echo "--------------------------"
echo "        fd"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-fd.sh


# nnn
echo ""
echo "--------------------------"
echo "        nnn"
echo "--------------------------"
./_setup-nnn.sh


# xsv ---better csvtools ---
echo ""
echo "--------------------------"
echo "        xsv"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-xsv.sh


# gotop --system monitor ---
echo ""
echo "--------------------------"
echo "        gotop"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-gotop.sh
