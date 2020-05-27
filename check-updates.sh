#!/usr/bin/env bash

parallel ./_setup-{}.sh < check-updates-apps.txt
[ -x "$(command -v joplin)" ] && ./_setup-joplin.sh
