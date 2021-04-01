# Stole from https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/SamplePSReadLineProfile.ps1

# --------------------
#  PSReadLine
# --------------------
Import-Module PSReadLine
# Set emacs-like readline keybinding including ctrl+f, ctrl+b, ctrl+a, ctrl+k, ...
Set-PSReadLineOption -EditMode Emacs
# Show input prediction baesd on history
Set-PSReadLineOption -PredictionSource History
# Handling of history search
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward


# --------------------
#  PSFzf
# --------------------
Import-Module PSFzf
# override tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# replace ctrl+t behavior to show directories with fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
# replace ctrl+r behavior to search history with fzf
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
