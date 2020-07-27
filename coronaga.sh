#!/usr/bin/env bash

## Scrape Georgia DPH data and obtains in JSON
##
## Example:
## $ coronaga
## {
##   "currdate": "7/7/2020, 2:50:05 PM",
##   "total_tests": 1151609,
##   "confirmed_covid": 100470,
##   "icu": 2471,
##   "hospitalization": 12226,
##   "deaths": 2899
## }


##----------------------------------------------------------
## Cut out JSON-like segment containing a keyword in TEXT
##
##  Global:
##      TEXT
##  Arguments:
##      keyword to find
##      text body
##  Outputs:
##      JSON-like segment appeared in text
##----------------------------------------------------------
function f {
    local kwd="$1"
    local text="$2"
    if [[ -x "$(command -v rg)" ]]; then
        local search=rg
    else
        local search=grep
    fi
    local chunk
    chunk="$("$search" -F "$kwd" <<< "$text")"

    # -a means --text
    # -o means --only-matching
    # -b means --byte-ofset
    # -f means --fixed-strings
    #
    # search for kwd location and take the first appearance
    local thresh
    thresh="$("$search" -aobF "$kwd" <<< "$chunk" | cut -d':' -f1 | head -1)"
    # search for { location right before the kwd appearance
    local begin
    begin="$("$search" -aobF \{ <<< "$chunk" | cut -d':' -f1 | awk -v th="$thresh" '{ if ($1 < th) print $1 }' | tail -1)"
    # search for {} location right after the kwd appearance
    local end
    end="$("$search" -aobF \} <<< "$chunk" | cut -d':' -f1 | awk -v th="$thresh" '{ if ($1 > th) print $1 }' | head -1)"
    # slice the segment of the form "{ ... kwd ... }"
    cut -c $((begin+1))-$((end+1)) <<< "$chunk"
}

##----------------------------------------------------------
## Fetch javascript file, slice out JSON segments,
## and concatenate them into a single JSON
##----------------------------------------------------------
function main {
    readonly URI="https://ga-covid19.ondemand.sas.com/static/js/main.js"
    local chunk
    chunk="$(curl -s "$URI" | tr '()' '\n')"
    local out1
    out1="$(f \"currdate\" "$chunk")"
    local out2
    out2="$(f \"confirmed_covid\" "$chunk")"
    jq -s '.[0] * .[1]' <<< "$out1 $out2"
}


## execute the script
main
