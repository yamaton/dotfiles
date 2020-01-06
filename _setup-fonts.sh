#!/usr/bin/env bash

#
# Per-user font installation
#

mkdir -p ~/.fonts && cd ~/.fonts

echo "-------------------"
echo "  Source Code Pro"
echo "-------------------"
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf

echo "-------------------"
echo "  IBM Plex Mono"
echo "-------------------"
wget -N https://github.com/IBM/plex/releases/download/v4.0.2/OpenType.zip
unzip OpenType.zip

echo "-------------------"
echo "  Hasklig"
echo "-------------------"
wget -N https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
unzip Hasklig-1.1.zip

echo "-------------------"
echo "  Inconsolata"
echo "-------------------"
wget -N https://www.levien.com/type/myfonts/Inconsolata.otf

echo "-------------------"
echo "  Noto CJK"
echo "-------------------"
if [ -x "$(command -v apt)" ]; then
    sudo apt update
    sudo apt install -y fonts-noto-cjk
else
    wget -N https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
    wget -N https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip
    unzip NotoSansCJKjp-hinted.zip
    unzip NotoSerifCJKjp-hinted.zip
fi

fc-cache -fv
