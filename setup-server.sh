#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
CONFDIR="${HOME}/confs"

echo ""
echo "BASEDIR: ${BASEDIR}"
echo "CONFDIR: ${CONFDIR}"
echo ""

# configurations are in ~/confs
[[ ! -d "${CONFDIR}" ]] &&  mkdir "${CONFDIR}"


# update the system and install essential
if [[ "$(uname -s)" == "Linux" ]] && [[ "$(command -v apt)" ]]; then
    sudo apt update && sudo apt full-upgrade
    sudo apt install -y curl openssh-server
fi


# latest git (ubuntu only)
if [[ "$(lsb_release -i -s)" == "Ubuntu" ]] || [[ "$(lsb_release -i -s)" == "Pop" ]]; then
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
[[ -f ~/.less_termcap ]] && mv -f ~/.less_termcap ~/.less_termcap.backup
ln -sf "${BASEDIR}/.less_termcap" ~


# misc essential software
echo ""
echo "--------------------------"
echo "    software via apt"
echo "--------------------------"
cd "${BASEDIR}" || exit
./_setup-misc.sh


# custom installations
APPS=(tmux emacs neovim tealdeer cheatsheet ripgrep bat fd parallel nnn fzf broot delta topgrade zoxide yq hyperfine)
for app in "${APPS[@]}"; do
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

