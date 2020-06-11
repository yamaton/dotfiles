#!/usr/bin/env bash

function f {
    kwd="$1"
    if [ -x "$(command -v rg)" ]; then
        search=rg
    else
        search=grep
    fi
    chunk=$("$search" -F "$kwd" <<< $TEXT)
    # -aobf means --text --only-matching --byte-ofset --fixed-strings
    th=$($search -aobF $kwd <<< $chunk | cut -d':' -f1 | head -1)
    begin=$($search -aobF \{ <<< $chunk | cut -d':' -f1 | awk -v thresh="$th" '{ if ($1 < thresh) print $1 }' | tail -1)
    end=$($search -aobF \} <<< $chunk | cut -d':' -f1 | awk -v thresh="$th" '{ if ($1 > thresh) print $1 }' | head -1)
    cut -c "$((begin+1))"-"$((end+1))" <<< $chunk
}


function coronaga {
    URL="https://ga-covid19.ondemand.sas.com/static/js/main.js"
    TEXT=$(curl -s "$URL" | tr '()' '\n\n')
    out1=$(f \"currdate\")
    out2=$(f \"confirmed_covid\")
    jq -s '.[0] * .[1]' <<< "$out1 $out2"
}


coronaga
