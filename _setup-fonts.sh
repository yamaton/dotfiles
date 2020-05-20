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
VERSION=4.0.2
URI="https://github.com/IBM/plex/releases/download/v${VERSION}/OpenType.zip"
FILENAME=$(basename "$URI")
wget -N "$URI"
unzip "$FILENAME" -d "IBM-Plex-${VERSION}"
rm -f "$FILENAME"


echo ""
echo "-------------------"
echo "  Hasklig"
echo "-------------------"
VERSION=1.1
URI="https://github.com/i-tu/Hasklig/releases/download/${VERSION}/Hasklig-${VERSION}.zip"
FILENAME=$(basename "$URI")
wget -N "$URI"
unzip "$FILENAME" -d "${FILENAME%.*}"
rm -f "$FILENAME"


echo ""
echo "-------------------"
echo "  Inconsolata"
echo "-------------------"
wget -N https://www.levien.com/type/myfonts/Inconsolata.otf


echo ""
echo "-------------------"
echo "  Noto CJK"
echo "-------------------"
if [ -x "$(command -v apt)" ]; then
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
VERSION=2005.15
URI="https://github.com/microsoft/cascadia-code/releases/download/v${VERSION}/CascadiaCode_${VERSION}.zip"
FILENAME=$(basename "$URI")
wget -N "$URI"
unzip "$FILENAME" -d "${FILENAME%.*}"
rm -f "$FILENAME"
rm -rf "${FILENAME%.*}/ttf"
rm -rf "${FILENAME%.*}/woff2"



echo ""
echo "-------------------"
echo "  Fira Code"
echo "-------------------"
VERSION=4
URI="https://github.com/tonsky/FiraCode/releases/download/${VERSION}/Fira_Code_v${VERSION}.zip"
FILENAME=$(basename "$URI")
wget -N "$URI"
unzip "$FILENAME" -d "${FILENAME%.*}"
rm -f "$FILENAME"
rm -rf "${FILENAME%.*}/${DIR}/ttf"
rm -rf "${FILENAME%.*}/${DIR}/variable_ttf"
rm -rf "${FILENAME%.*}/${DIR}/woff"
rm -rf "${FILENAME%.*}/${DIR}/woff2"


echo ""
echo "-------------------"
echo "  Ricty Diminished"
echo "-------------------"
VERSION=3.2.3
URI="https://github.com/edihbrandon/RictyDiminished/archive/${VERSION}.zip"
FILENAME=$(basename "$URI")
wget -N "$URI"
unzip "$FILENAME"
rm -f "$FILENAME"


fc-cache -fv

