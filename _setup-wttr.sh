#!/usr/bin/env bash

mkdir -p ~/.local/bin
curl https://wttr.in/:bash.function > ~/.local/bin/wttr
chmod +x ~/.local/bin/wttr
