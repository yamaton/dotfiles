# env
set -gx LANG en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8
set -gx EDITOR nvim
set -gx PAGER less
set -gx XDG_CONFIG_HOME ~/.config

# telemetry optout
set -gx DO_NOT_TRACK 1  # https://consoledonottrack.com/
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx POWERSHELL_TELEMETRY_OPTOUT 1
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx STNOUPGRADE 1   # syncthing
set -gx AZURE_CORE_COLLECT_TELEMETRY 0

# abbriviation
abbr -a -- rm trash
abbr -a -- mv 'mv -i'
abbr -a -- cp 'cp -i'
abbr -a -- mkdir 'mkdir -p'
abbr -a -- vim nvim
abbr -a -- j z
abbr -a -- cht cht.sh
abbr -a -- tree tre
abbr -a -- du 'ncdu --color dark'
abbr -a -- btc 'curl rate.sx'

# set fish_complete_path
set -a fish_complete_path ~/.config/fish/completions/extra  ~/.config/fish/completions/bio

# local bin
fish_add_path ~/.local/bin
fish_add_path ~/bin
fish_add_path ~/.dotnet

# disable welcome message
set -g fish_greeting

# replace ssh with 'kitty +kitten ssh'
if test $TERM = xterm-kitty && type -q kitty
    alias ssh="kitty +kitten ssh"
end

# rust
fish_add_path ~/.cargo/bin
set -gx RUST_BACKTRACE 1

# go
if type -q go
    fish_add_path (go env GOPATH)/bin
end

# dotnet tools
fish_add_path ~/.dotnet/tools

# nim
fish_add_path ~/.nimble/bin

# cht.sh
set -gx CHTSH $XDG_CONFIG_HOME/cht.sh

# initialize conda
if test -x "$HOME/mambaforge/bin/conda"
    eval "$HOME/mambaforge/bin/conda" "shell.fish" "hook" $argv | source
else if test -x "$HOME/miniconda3/bin/conda"
    eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
end

# initialize mamba
if test -f "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
    source "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
else if test -f "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"
    source "$HOME/miniconda3/etc/fish/conf.d/mamba.fish"
end

# system update
alias bu="topgrade; sudo apt update && sudo apt full-upgrade; mamba update -c conda-forge --all -y; check-updates-utils"

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# pipx, kitty, and other
fish_add_path ~/.local/bin

# ruby gems
set -gx GEM_HOME ~/.gems
fish_add_path ~/.gems/bin

# yarn
fish_add_path ~/.yarn/bin

# npm
fish_add_path ~/.local/bin/node/bin

# deno
set -gx DENO_INSTALL ~/.deno
fish_add_path $DENO_INSTALL/bin

# ghcup
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
fish_add_path $HOME/.cabal/bin
fish_add_path $HOME/.ghcup/bin # ghcup-env

# source-highlight in less
set -gx LESSOPEN '| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
set -gx LESS ' -R '

# colorful man
# ported from ~/.less_termcap
set -x LESS_TERMCAP_mb (tput bold; tput setaf 2) # green
set -x LESS_TERMCAP_md (printf "\e[1;31m")
set -x LESS_TERMCAP_me (tput sgr0)
set -x LESS_TERMCAP_so (printf "\e[1;44;33m")
set -x LESS_TERMCAP_se (tput rmso; tput sgr0)
set -x LESS_TERMCAP_us (printf "\e[1;32m")
set -x LESS_TERMCAP_ue (tput rmul; tput sgr0)
set -x LESS_TERMCAP_mr (tput rev)
set -x LESS_TERMCAP_mh (tput dim)
set -x LESS_TERMCAP_ZN (tput ssubm)
set -x LESS_TERMCAP_ZV (tput rsubm)
set -x LESS_TERMCAP_ZO (tput ssupm)
set -x LESS_TERMCAP_ZW (tput rsupm)
set -x GROFF_NO_SGR 1    # For Konsole and Gnome-terminal

# kitty
if [ "$TERM" = "xterm-kitty" ] && type -q kitty
    alias icat="kitty +kitten icat"
end

# WSL
if string match -i -q '*microsoft*' (uname -r)
    alias firefox='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
    alias typora='/mnt/c/Program\ Files/Typora/Typora.exe'
    # VcXsrv ... now switching to WSLg
    # set -gx DISPLAY (ip route | grep default | cut -d ' ' -f 3):0
    # vagrant
    set -gx VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1
end

# ghcup
fish_add_path ~/.ghcup/bin
