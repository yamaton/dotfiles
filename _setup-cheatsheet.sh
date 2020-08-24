#!/usr/bin/env bash

mkdir -p ~/bin
curl https://cht.sh/:cht.sh > ~/bin/cht.sh
chmod +x ~/bin/cht.sh

chthome="${CHTSH:-"$HOME"/.config/cht.sh}"
mkdir -p "$chthome"
echo "CHTSH_QUERY_OPTIONS=\"style=rrt\"" > "$chthome"/cht.sh.conf
