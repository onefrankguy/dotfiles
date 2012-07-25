PROMPT='%{$fg[magenta]%}Wizard%{$reset_color%} in %{$fg_bold[green]%}${${PWD/#$HOME/~}##*/}%{$reset_color%}$(git_prompt_info) $ '
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
