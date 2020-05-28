#!/usr/bin/env bash

BASEDIR=$(dirname "$(readlink -f "$0")")

parallel "$BASEDIR"/_setup-{}.sh <  "$BASEDIR"/check-updates-apps.txt
[ -x "$(command -v joplin)" ] &&  "$BASEDIR"/_setup-joplin.sh
