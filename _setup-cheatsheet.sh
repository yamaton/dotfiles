#!/usr/bin/env bash

mkdir -p ~/.local/bin
curl https://cht.sh/:cht.sh > ~/.local/bin/cht.sh
chmod +x ~/.local/bin/cht.sh

chthome="${CHTSH:-"$HOME"/.config/cht.sh}"
mkdir -p "$chthome"
echo "CHTSH_QUERY_OPTIONS=\"style=rrt\"" > "$chthome"/cht.sh.conf
