#!/usr/bin/env bash

BASEDIR="$(dirname "$(readlink -f "$0")")"
APPLIST=("$(cat "$BASEDIR"/check-updates-apps.txt)")

echo ""
echo "―― "$(date +"%H:%M:%S")" - Utils ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
for app in ${APPLIST[*]}; do
    case "$app" in
        "neovim"   ) cmd=nvim ;;
        "ripgrep"  ) cmd=rg ;;
        "tealdeer" ) cmd=tldr ;;
        *) cmd="$app" ;;
    esac
    [[ -x "$(command -v "$cmd")" ]] && "${BASEDIR}/_setup-${app}.sh"
done
[[ -x "$(command -v joplin)" ]] &&  "$BASEDIR"/_setup-joplin.sh
