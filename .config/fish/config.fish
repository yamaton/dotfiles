# env
set -gx LANG en_US.UTF-8
set -gx LC_NUMERIC en_US.UTF-8
set -gx EDITOR nvim
set -gx PAGER less
set -gx XDG_CONFIG_HOME ~/.config

# abbriviation
abbr -a -U -- rm trash
abbr -a -U -- mv 'mv -i'
abbr -a -U -- mkdir 'mkdir -p'
abbr -a -U -- vim nvim
abbr -a -U -- j z
abbr -a -U -- cht cht.sh
abbr -a -U -- ncdu 'ncdu --color dark'
abbr -a -U -- btc 'curl rate.sx'

# local bin
fish_add_path ~/bin

# disable welcome message
set -g fish_greeting

# rust
fish_add_path ~/.cargo/bin
set -gx RUST_BACKTRACE 1

# go
if type -q go
    fish_add_path (go env GOPATH)/bin
end

# dotnet and powershell optout
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx POWERSHELL_TELEMETRY_OPTOUT 1

# cht.sh
set -gx CHTSH $XDG_CONFIG_HOME/cht.sh

# conda initialize
eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source

# system update
alias bu="topgrade; sudo apt update && sudo apt full-upgrade; mamba update --all -y; check-updates-utils"

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# pipx
fish_add_path ~/.local/bin

# ruby gems
set -gx GEM_HOME ~/.gems
fish_add_path ~/.gems/bin

# npm
fish_add_path ~/bin/node/bin

# deno
fish_add_path $DENO_INSTALL/bin
set -gx DENO_INSTALL ~/.deno

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
set -x GROFF_NO_SGR 1         # For Konsole and Gnome-terminal


# kitty
if [ "$TERM" = "xterm-kitty" ] && type -q kitty
    alias icat="kitty +kitten icat"
end


# WSL
if string match -i -q '*microsoft*' (uname -r)
    alias firefox='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
    alias typora='/mnt/c/Program\ Files/Typora/Typora.exe'
    # VcXsrv
    set -gx DISPLAY (ip route | grep default | cut -d ' ' -f 3):0
    # vagrant
    set -gx VAGRANT_WSL_ENABLE_WINDOWS_ACCESS 1
end
