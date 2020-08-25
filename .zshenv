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

## local bin
export PATH="$HOME/bin:$PATH"

## rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_BACKTRACE=1

## dotnet optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1

## cht.sh
export CHTSH="$HOME"/.config/cht.sh

## npm
export PATH="$PATH:$HOME/bin/node/bin"

## pipx
export PATH="$HOME/.local/bin:$PATH"


## MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then

    # homebrew
    export PATH="/usr/local/bin:/usr/local/lib:/usr/local/sbin:${PATH}"

    # add user's bin folder
    export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"

    # GNU coreutils
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:${PATH}"
    export MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:${MANPATH}"

fi
