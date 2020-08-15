#!/usr/bin/env bash

#
# Per-user font installation
#

mkdir -p ~/.fonts && cd ~/.fonts

echo ""
echo "-------------------"
echo "  Source Code Pro"
echo "-------------------"
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf


echo ""
echo "-------------------"
echo "  IBM Plex Mono"
echo "-------------------"
version=5.0.0
uri="https://github.com/IBM/plex/releases/download/v${version}/OpenType.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename" -d "IBM-Plex-${version}"
rm -f "$filename"


echo ""
echo "-------------------"
echo "  Hasklig"
echo "-------------------"
version=1.1
uri="https://github.com/i-tu/Hasklig/releases/download/${version}/Hasklig-${version}.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename" -d "${filename%.*}"
rm -f "$filename"


echo ""
echo "-------------------"
echo "  Inconsolata"
echo "-------------------"
wget -N https://www.levien.com/type/myfonts/Inconsolata.otf


echo ""
echo "-------------------"
echo "  Noto CJK"
echo "-------------------"
if [[ -x "$(command -v apt)" ]]; then
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
echo "  Cascadia"
echo "-------------------"
version=2007.01
uri="https://github.com/microsoft/cascadia-code/releases/download/v${version}/CascadiaCode-${version}.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename" -d "${filename%.*}"
rm -f "$filename"
rm -rf "${filename%.*}/otf"
rm -rf "${filename%.*}/woff2"



echo ""
echo "-------------------"
echo "  Fira Code"
echo "-------------------"
version=5.2
uri="https://github.com/tonsky/FiraCode/releases/download/${version}/Fira_Code_v${version}.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename" -d "${filename%.*}"
rm -f "$filename"
rm -rf "${filename%.*}/${DIR}/variable_ttf"
rm -rf "${filename%.*}/${DIR}/woff"
rm -rf "${filename%.*}/${DIR}/woff2"


echo ""
echo "-------------------"
echo "  Ricty Diminished"
echo "-------------------"
version=3.2.3
uri="https://github.com/edihbrandon/RictyDiminished/archive/${version}.zip"
filename="$(basename "$uri")"
wget -N "$uri"
unzip "$filename"
rm -f "$filename"


fc-cache -fv

