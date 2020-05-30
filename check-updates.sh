#!/usr/bin/env bash

BASEDIR=$(dirname "$(readlink -f "$0")")
APPLIST=$(sed '/^\s*$/d' "$BASEDIR"/check-updates-apps.txt)
for app in $APPLIST; do
    "${BASEDIR}/_setup-${app}.sh"
done 
[ -x "$(command -v joplin)" ] &&  "$BASEDIR"/_setup-joplin.sh
