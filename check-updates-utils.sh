#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

BASEDIR="$(dirname "$(readlink -f "$0")")"
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
    [[ "$(command -v "$cmd")" ]] && "${BASEDIR}/_setup-${app}.sh"
done

if [[ "$(command -v joplin)" ]];
    then "$BASEDIR"/_setup-joplin.sh
fi

