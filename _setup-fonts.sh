#!/usr/bin/env bash

[ ! -d ~/.fonts ] && mkdir ~/.fonts
cd ~/.fonts

echo "-------------------"
echo "  Source Code Pro"
echo "-------------------"
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf
wget -N https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf

echo "-------------------"
echo "  IBM Plex Mono"
echo "-------------------"
wget -N https://github.com/IBM/plex/releases/download/v1.2.3/OpenType.zip
unzip OpenType.zip

echo "-------------------"
echo "  Hasklig"
echo "-------------------"
wget -N https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip

fc-cache -fv
