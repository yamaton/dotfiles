#!/usr/bin/env bash

#
# Per-user font installation
#

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
readonly BASEDIR
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts

echo ""
echo "-------------------"
echo "  Source Code Pro"
echo "-------------------"
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf


echo ""
echo "-------------------"
echo "  IBM Plex Mono"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-ibm-plex
else
    ownerrepo="IBM/plex"
    version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
    uri="https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip"
    filename="$(basename "$uri")"
    wget -N "$uri"
    unzip "$filename" -d "IBM-Plex-${version}"
    rm -f "$filename"
fi


echo ""
echo "-------------------"
echo "  Hasklig"
echo "-------------------"
ownerrepo="i-tu/Hasklig"
version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
uri="https://github.com/i-tu/Hasklig/releases/download/${version}/Hasklig-${version}.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename" -d "${filename%.*}"
rm -f "$filename"


echo ""
echo "-------------------"
echo "  Inconsolata"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-inconsolata
else
    wget -N https://www.levien.com/type/myfonts/Inconsolata.otf
fi


echo ""
echo "-------------------"
echo "  Noto CJK"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-noto-cjk
else
    wget -N https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
    wget -N https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip
    unzip NotoSansCJKjp-hinted.zip -d NotoSansCJKjp-hinted
    unzip NotoSerifCJKjp-hinted.zip -d NotoSerifCJKjp-hinted
fi


echo ""
echo "-------------------"
echo "  Cascadia Code"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-cascadia-code
else
    ownerrepo="microsoft/cascadia-code"
    version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
    uri="https://github.com/microsoft/cascadia-code/releases/download/v${version}/CascadiaCode-${version}.zip"
    filename="$(basename "$uri")"
    wget -N "$uri"
    unzip "$filename" -d "${filename%.*}"
    rm -f "$filename"
    rm -rf "${filename%.*}/otf"
    rm -rf "${filename%.*}/woff2"
fi


echo ""
echo "-------------------"
echo "  Fira Code"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-fira-code
else
    ownerrepo="tonsky/FiraCode"
    version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
    uri="https://github.com/tonsky/FiraCode/releases/download/${version}/Fira_Code_v${version}.zip"
    filename="$(basename "$uri")"
    wget -N "$uri"
    unzip "$filename" -d "${filename%.*}"
    rm -f "$filename"
    rm -rf "${filename%.*}/${DIR}/variable_ttf"
    rm -rf "${filename%.*}/${DIR}/woff"
    rm -rf "${filename%.*}/${DIR}/woff2"
fi


echo ""
echo "-------------------"
echo "  Jetbrains Mono"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-jetbrains-mono
else
    ownerrepo="JetBrains/JetBrainsMono"
    version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
    dirname=jetbrainsmono
    uri="https://github.com/JetBrains/JetBrainsMono/releases/download/v${version}/JetBrainsMono-${version}.zip"
    filename="$(basename "$uri")"
    wget -N "$uri"
    rm -rf "$dirname"
    unzip "$filename" -d "$dirname"
    rm -rf "${dirname}/web"
    rm -f "$filename"
fi


echo ""
echo "-------------------"
echo "  JuliaMono"
echo "-------------------"
ownerrepo="cormullion/juliamono"
version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
dirname=juliamono
uri="https://github.com/cormullion/juliamono/releases/download/v${version}/JuliaMono.tar.gz"
filename="$(basename "$uri")"
rm -rf "$dirname" && mkdir "$dirname" && cd "$dirname" || exit
wget -N "$uri"
tar -xvf "$filename"
rm -f "$filename"
cd ..



echo ""
echo "-------------------"
echo "  Ricty Diminished"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-ricty-diminished
else
    ownerrepo="edihbrandon/RictyDiminished"
    version="$("$BASEDIR"/get-version-github.sh "$ownerrepo")"
    uri="https://github.com/edihbrandon/RictyDiminished/archive/refs/tags/${version}.zip"
    filename="$(basename "$uri")"
    wget -N "$uri"
    unzip "$filename"
    rm -f "$filename"
fi


echo ""
echo "-------------------"
echo "  Open Sans"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-open-sans
else
    filename="open-sans.zip"
    wget -N "https://fonts.google.com/download?family=Open%20Sans" -O "$filename"
    unzip "$filename" -d "${filename%.*}"
    rm -f "$filename"
fi


echo ""
echo "-------------------"
echo "  Lato"
echo "-------------------"
if [[ "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y fonts-lato
else
    filename="lato.zip"
    wget -N "https://fonts.google.com/download?family=Lato" -O "$filename"
    unzip "$filename" -d "${filename%.*}"
    rm -f "$filename"
fi



## ----------------
##   Update DB
## ----------------
fc-cache -f -v
