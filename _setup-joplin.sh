#!/usr/bin/env bash

wget -qO - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
mkdir -p ~/.local/bin
ln -sf ~/.joplin/Joplin.AppImage ~/.local/bin/joplin
