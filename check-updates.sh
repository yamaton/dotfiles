#!/usr/bin/env bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
APPLIST=("$(cat "$BASEDIR"/check-updates-apps.txt)")

echo ""
echo "―― $(date +"%H:%M:%S") - Utils ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
for app in ${APPLIST[*]}; do
    case "$app" in
        "neovim"   ) cmd=nvim ;;
        "ripgrep"  ) cmd=rg ;;
        "tealdeer" ) cmd=tldr ;;
        *) cmd="$app" ;;
    esac
    [[ -x "$(command -v "$cmd")" ]] && "${BASEDIR}/_setup-${app}.sh"
done

if [[ -x "$(command -v joplin)" ]];
    then "$BASEDIR"/_setup-joplin.sh
fi

