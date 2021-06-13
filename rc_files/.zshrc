# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/crystal/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ---------------------------------------------------------------------
# ENV EDITS ON SHELL 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/crystal/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/crystal/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/crystal/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/crystal/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# FZF set up.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ghc initialize
[ -f ~/.ghcup/env ] && source ~/.ghcup/env

# Edit path

__prepend_to_path_if_exists () {
    local p="$1"
    [[ -d "$p" ]] && export PATH="$p:$PATH"
}

__append_to_path_if_exists () {
    local p="$1"
    [[ -d "$p" ]] && export PATH="$PATH:$p"
}

__append_to_path_if_exists '/snap/bin'
__prepend_to_path_if_exists "$HOME/.cabal/bin"
__prepend_to_path_if_exists "$HOME/.cargo/bin"
__prepend_to_path_if_exists "$HOME/.sdkman/candidates/kotlin/current/bin"
__prepend_to_path_if_exists "$HOME/.local/bin"
__prepend_to_path_if_exists "$HOME/bin"

#export PATH="$HOME/bin:/snap/bin:$HOME/.sdkman/candidates/kotlin/current/bin:$HOME/.cargo/bin:$PATH"
#export PATH="$HOME/.cabal/bin:$PATH"
#export PATH="$HOME/.local/bin:$PATH"
export fpath=("$HOME/.zfunctions" $fpath)
export fpath=($fpath "$HOME/.zsh/pure")

[[ -s "/home/crystal/.sdkman/bin/sdkman-init.sh" ]] \
    && source "/home/crystal/.sdkman/bin/sdkman-init.sh"

# ---------------------------------------------------------------------
# Aliases

alias ls="ls -a --color='auto'"

# ---------------------------------------------------------------------
# Global constants
export T="/media/crystal/tower_1TB"

export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
#eval $(keychain -q --eval "$HOME/.ssh/id_ed25519")


# ---------------------------------------------------------------------
# Oh-My-Zsh Prompt Start

autoload -U promptinit
promptinit
prompt pure
