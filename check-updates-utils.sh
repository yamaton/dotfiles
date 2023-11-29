#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Get the Bash version
bash_version=$(bash --version | head -n1 | cut -d " " -f4 | cut -d "(" -f1)

# Extract major version
major_version=${bash_version%%.*}

# Check if the major version is less than or equal to 3
if [ "$major_version" -le 3 ]; then
    echo "Bash version 3 or lower detected. Exiting."
    exit 1
fi


BASEDIR="$(dirname "$(readlink -f "$0")")"
# -t strips newline
readarray -t APPLIST < "$BASEDIR/check-updates-apps.txt"
echo ""
echo "―― $(date +"%H:%M:%S") - Utils ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
for app in "${APPLIST[@]}"; do
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

