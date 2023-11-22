# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} \u2717"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} \u26D4"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='
%{$fg_bold[red]%}[%D{%Y-%m-%d} %*]%{$reset_color%} %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info)
$ '

VIRTUAL_ENV_DISABLE_PROMPT=0
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=" %{$fg[green]%} 🐍"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX
