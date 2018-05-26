## =======================================
##             ENV variables
## =======================================
export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export SHELL=zsh

## =======================================
##            Command History
## =======================================
HISTFILE=~/.zsh_history
HISTSIZE=80000
SAVEHIST=80000


## =======================================
##        Jump to Directories
## =======================================
alias repos='~/repos'


## =======================================
##            Alias Commands
## =======================================
alias ls="ls --color"
alias la='ls -A'
alias ll='ls -alF'

alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"

alias base="conda activate"
alias tf="conda activate tf"

alias vim=nvim
alias bu="sudo apt update && sudo apt full-upgrade && base && conda update --all && tf && conda update --all"

## =======================================
##      Run application by Extension
## =======================================
alias -s txt=code
alias -s cc=code
alias -s cpp=code
alias -s tex=code
alias -s py=code

## =======================================
##             ZSH config
## =======================================

## Checkmarked [✓] settings are from .zshrc by naoya@Hatena.
##  http://bloghackers.net/~naoya/webdb40/files/dot.zshrc

## Completion
##  Examples: Type "ls -" then press TAB
##            Type "tar " then press TAB
autoload -U compinit
compinit

## Use color [✓]
setopt prompt_subst

# Do not add duplicates in a row to command history [✓]
setopt hist_ignore_dups

# Share command history [✓]
setopt share_history

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
autoload zmv

## Enable zargs
autoload zargs

## Change directory without typing cd [✓]
setopt auto_cd

## Close parenthesis automatically [✓]
setopt auto_param_keys

## Add / (slash) automatically after a directory name [✓]
setopt auto_param_slash

## If a line starts with a space, don't save it.
## https://stackoverflow.com/questions/171563/whats-in-your-zshrc/171564#171564
setopt hist_ignore_space
setopt hist_no_store

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


## Syntax Highlighting
# Use homebrew to install zsh-syntax-highlighting
source ~/confs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH_HIGHLIGHT_STYLES[command]='fg=yellow'
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

## Bash-like comment in command line
## See https://stackoverflow.com/questions/11670935/comments-in-command-line-zsh
setopt interactivecomments


## =======================================
##     Prompt Customization
## =======================================

## Use colors in prompt
autoload colors && colors

# PROMPT="%{$fg[green]%}%n🌙 %{$fg[green]%}%m %{$fg[yellow]%}➤ %{$reset_color%} "


## StackOverflow mentions that zsh comes with builtin colored prompt themes
## Type command "prompt -p adam1" for example.
autoload -U promptinit && promptinit


# unalias run-help
# autoload run-help
# HELPDIR=/usr/local/share/zsh/help


## Zsh Git Prompt
## https://github.com/olivierverdier/zsh-git-prompt
source ~/confs/zsh-git-prompt/zshrc.sh

# an example prompt
# PROMPT='%B%m%~%b$(git_super_status) %# '
PROMPT='%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[green]%}%m%{$reset_color%}$(git_super_status)%{$fg[yellow]%}➤%{$reset_color%} '
RPROMPT="%{$fg[green]%}[%{$fg[magenta]%}%~%{$fg[green]%}] %{$fg[cyan]%}%T %{$reset_color%}"

## TLDR completion
source ~/.tldr.complete

## Bazel completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

## autojump
. /usr/share/autojump/autojump.zsh

## conda (> 4.4)
. ~/miniconda3/etc/profile.d/conda.sh
source ~/.tldr.complete
source ~/.tldr.complete
