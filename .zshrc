# shellcheck disable=SC2148
# shellcheck disable=SC2034

## =======================================
##        Jump to Directories
## =======================================
alias repos='~/repos'


## =======================================
##            Alias Commands
## =======================================
alias ls="ls --color"
alias la='ls -A'
alias ll='ls -alFh'

alias mv="mv -i"
alias cp="cp -i"
if [[ -x "$(command -v trash)" ]]; then
    alias rm=trash
else
    alias rm="rm -i"
fi
alias mkdir="mkdir -p"
alias cht="cht.sh"

alias ncdu="ncdu --color dark"

alias base="conda deactivate; conda activate"
alias tf="conda deactivate; conda activate tf"
alias torch="conda deactivate; conda activate torch"

[[ -x "$(command -v nvim)" ]] && alias vim=nvim

# Updates in MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    alias bu='
    brew upgrade;
    conda update -n base --all -y;
    conda update -n tf --all -y;
    conda update -n torch --all -y;
    tldr --update;
    '
    function ql {
        qlmanage -p "$@" >& /dev/null
    }
fi

# Updates in Linux
if [[ "$(uname -s)" == "Linux" ]] && [[ -x "$(command -v apt)" ]]; then
    alias bu='
    sudo apt update;
    sudo apt full-upgrade;
    conda update -n base --all -y;
    conda update -n tf --all -y;
    check-updates-utils;
    tldr --update;
    '
fi

# Open in WSL2
if [[ "$(uname -r)" == *'-microsoft-'* ]]; then
    alias firefox='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
    alias typora='/mnt/c/Program\ Files/Typora/Typora.exe'
fi

##-------------------------------------------------------------
## Removes color from stdin, and writes to stdout
##
## Example:
##   cht.sh bash remove color | removecolor | bat -l bash
##-------------------------------------------------------------
alias removecolor="sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'"


##-------------------------------------------------------------
## Shows ranking of countries and US states by COVID-19 cases
##
## Arguments:
##   Number of top countries (default: 20)
##   Number of top US states (default: 15)
## Outputs:
##   Writes ranks to stdout
##-------------------------------------------------------------
function corona {
    local n_countries="${1:-20}"
    local n_us_states="${2:-15}"
    parallel curl -s https://corona-stats.online{} ::: \
    "/states/us?minimal=true&top=${n_us_states}" \
    "?minimal=true&top=${n_countries}"
}
alias btc="curl rate.sx"


## =======================================
##      Run application by Extension
## =======================================
alias -s "{txt,md,c,cc,cpp,tex,py,hs,fs,go}"=code


## =======================================
##             ZSH config
## =======================================

## Checkmarked [✓] settings are from .zshrc by naoya@Hatena.
##  http://bloghackers.net/~naoya/webdb40/files/dot.zshrc

## Completion
##  Examples: Type "ls -" then press TAB
##            Type "tar " then press TAB
autoload -Uz compinit; compinit

## Use color [✓]
setopt prompt_subst

## copied from https://github.com/Phantas0s/.dotfiles/blob/master/zsh/zshrc
setopt extended_history          # Write the history file in the ':start:elapsed;command' format.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups          # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups      # Delete an old recorded event if a new event is a duplicate.
setopt hist_find_no_dups         # Do not display a previously found event.
setopt hist_ignore_space         # Do not record an event starting with a space.
setopt hist_save_no_dups         # Do not write a duplicate event to the history file.
setopt hist_verify               # Do not execute immediately upon history expansion.

## Keyboad config ... emacs-like key binding (such as C-f, C-b)
bindkey -e

## Correct command [✓]
setopt correct

## Show file types in completion list [✓]
setopt list_types

## Disable beep [✓]
setopt nobeep

## Display list automatically [✓]
setopt auto_list

## Show recently-visited folders when "cd -" and TAB [✓]
setopt auto_pushd

## Remove duplicates in the auto_pushd list
setopt pushd_ignore_dups

## Browse history backward/forward by Ctl-p/Ctl-n
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Use #, ~, ^ as regular expression symbols for file names [✓]
setopt extended_glob

## Switch options by TAB [✓]
setopt auto_menu

## Enable zmv (a command for renaming files)
# autoload zmv

## Enable zargs
# autoload zargs

## Change directory without typing cd [✓]
setopt auto_cd

## Close parenthesis automatically [✓]
setopt auto_param_keys

## Add / (slash) automatically after a directory name [✓]
setopt auto_param_slash

## Predict entry
# autoload predict-on
# predict-on

## Expand aliases before completing
setopt complete_aliases # aliased ls needs if file/dir completions work

## colors used in auto complections
case "${TERM}" in
    kterm*|xterm*)
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

## Bash-like comment in command line
## See https://stackoverflow.com/questions/11670935/comments-in-command-line-zsh
setopt interactivecomments

## ctrl+u works like bash/readline
## https://stackoverflow.com/questions/3483604/which-shortcut-in-zsh-does-the-same-as-ctrl-u-in-bash
bindkey "^U" backward-kill-line


## =======================================
##     Prompt Configurations
## =======================================

## Use colors in prompt
autoload colors && colors

## StackOverflow mentions that zsh comes with builtin colored prompt themes
## Type command "prompt -p adam1" for example.
autoload -U promptinit && promptinit

## zsh-syntax-highlighting
if [[ "$(uname -s)" == "Darwin" ]]; then
    # following homebrew package instruction
    # https://formulae.brew.sh/formula/zsh-syntax-highlighting
    source "$(brew --prefix)"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## zsh-autosuggestions
if [[ "$(uname -s)" == "Darwin" ]]; then
    # following homebrew package instruction
    # https://formulae.brew.sh/formula/zsh-autosuggestions
    source "$(brew --prefix)"/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
## color sheme: https://coderwall.com/p/pb1uzq/z-shell-colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'

## zsh-git-prompt
## https://github.com/zsh-git-prompt/zsh-git-prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_PREFIX="%F{246}[%F"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{246}]%F "
ZSH_THEME_GIT_PROMPT_SEPARATOR="%F{246}|%F"

## Custom Prompt
PROMPT='${SSH_TTY:+"%F{green}%n%F{yellow}@%F{green}%m%F "}$(git_super_status)%F{yellow}$%F '
RPROMPT='%F{green}[%F{magenta}%~%F{green}] %F{cyan}%T%F'

## TLDR completion
# source ~/.tldr.complete

## Bazel completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

## autojump
source /usr/share/autojump/autojump.zsh

## conda
[[ -x "$HOME/miniconda3/bin/conda" ]] &&
    eval "$("$HOME"/miniconda3/bin/conda shell.zsh hook)"
# Hide (base) when base is active
PS1="$(echo "$PS1" | sed 's/(base) //')"

## source-highlight in less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

## colorful man
# shellcheck source=~/.less_termcap
[[ -e ~/.less_termcap ]] && source ~/.less_termcap


## gcloud autocompletion
source /usr/share/google-cloud-sdk/completion.zsh.inc


##-------------------------------------------------------------
## nnn: auto completion
zstyle ':completion:*' script ~/confs/nnn/scripts/auto-completion/zsh/_nnn

## nnn: cd on exit:
[[ ! -d ~/tmp ]] && mkdir ~/tmp
export NNN_TMPFILE="$HOME/tmp/nnn"
n()
{
    nnn -l "$@"
    if [[ -f "$NNN_TMPFILE" ]]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE"
    fi
}

##-------------------------------------------------------------
## Weather from wttr.in/:bash.function
## Examples:
##     wttr
##     wttr "New York"
##     wttr :help
##-------------------------------------------------------------
wttr()
{
    local request="wttr.in/${1}"
    [[ "$(tput cols)" -lt 125 ]] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

## fzf
# shellcheck source=~/.fzf.zsh
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

## starship
# eval "$(starship init zsh)"

## broot
# shellcheck source=~/.config/broot/launcher/bash/br
[[ -x "$(command -v broot)" ]] && source ~/.config/broot/launcher/bash/br
