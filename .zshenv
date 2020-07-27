## =======================================
##             ENV variables
## =======================================
export LANG=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export SHELL=zsh
export LC_NUMERIC=en_US.UTF-8

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh history
export HISTFILE=~/.zsh_history
export HISTSIZE=80000
export SAVEHIST=80000

## local bin
export PATH="$HOME/bin:$PATH"

## julia
export PATH="$HOME/bin/julia-1.4.2/bin:$PATH"

## rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_BACKTRACE=1

## dotnet optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1
