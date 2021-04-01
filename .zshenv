## =======================================
##             ENV variables
## =======================================
export LANG=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export SHELL=zsh
export LC_NUMERIC=en_US.UTF-8

# XDG
[[ "$(uname -s)" == "Linux" ]] && export XDG_CONFIG_HOME="$HOME/.config"

# zsh history
export HISTFILE=~/.zsh_history
export HISTSIZE=80000
export SAVEHIST=80000

# zsh syntax highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

## local bin
export PATH="$HOME/bin:$PATH"

## rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_BACKTRACE=1

## go
[[ -x "$(command -v go)" ]] && export PATH="$PATH:$(go env GOPATH)/bin"

## dotnet and powershell optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export POWERSHELL_TELEMETRY_OPTOUT=1

## cht.sh
export CHTSH="$HOME"/.config/cht.sh

## npm
export PATH="$PATH:$HOME/bin/node/bin"

## pipx
export PATH="$HOME/.local/bin:$PATH"

## ruby gems
export GEM_HOME="$HOME/.gems"
export PATH="$PATH:$HOME/.gems/bin"

## deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

## WSL2
if [[ "$(uname -r)" == *microsoft* ]]; then
    ## VcXsrv
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

## MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then

    # homebrew
    export PATH="/usr/local/bin:/usr/local/lib:/usr/local/sbin:${PATH}"

    # add user's bin folder
    export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"

    # GNU coreutils
    if [[ -x "$(command -v brew)" ]]; then
        export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:${PATH}"
        export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:${MANPATH}"
    fi
fi
