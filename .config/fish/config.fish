# conda initialize
eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source

# system update
alias bu="topgrade; sudo apt update; sudo apt full-upgrade; mamba update --all -y; check-updates-utils"

# zoxide
if type -q zoxide
    zoxide init fish | source
end
