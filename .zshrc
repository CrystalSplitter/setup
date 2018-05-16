# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory extendedglob
setopt HIST_IGNORE_ALL_DUPS
unsetopt autocd beep nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/crystal/.zshrc'

autoload -Uz colors compinit && colors
compinit
# End of lines added by compinstall
# -----------------------------------------------------------------------------
#

# Set PATH
export PATH="$HOME/bin:/usr/sbin:$PATH"

# Set easy rc access
export ZSHRC=~/.zshrc
export VIMRC=~/.vimrc
export TOWER="/mnt/tower_1tb/"

# Aliases
alias ls="ls -a --color=auto"

PS1="%n@%m %{$fg[red]%}%B[%3~]%b%{$reset_color%} "$'\n'"%{$fg[red]%}[%i]%{$reset_color%} %% "

# To get tmux working with colour, we can set this environment variable.
export TERM="rxvt-unicode-256color"

xrdb .Xresources
