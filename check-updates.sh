#!/usr/bin/env bash

BASEDIR=$(dirname "$(readlink -f "$0")")

sed '/^\s*$/d' "$BASEDIR"/check-updates-apps.txt | parallel "$BASEDIR"/_setup-{}.sh 
[ -x "$(command -v joplin)" ] &&  "$BASEDIR"/_setup-joplin.sh
