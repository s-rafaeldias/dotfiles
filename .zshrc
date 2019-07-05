# Path to your oh-my-zsh installation.
export ZSH=/home/rafael/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="avit"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator dir_writable go_version anaconda rbenv)

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  docker
  kubectl
  tmuxinator
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
else
   export EDITOR='nvim'
fi

if [[ -n $SSH_CONNECTION ]]; then
  ZSH_THEME="robbyrussell"
fi
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# ALIAS
alias zshconfig="nvim ~/.zshrc"
alias source_zsh="source ~/.zshrc"
alias vimconfig="nvim ~/.config/nvim/init.vim"

alias backup_dotfiles="cd ~/dotfiles/ && bash backup_dotfiles.sh"
alias update="sudo apt update && sudo apt upgrade -y"
alias tmux='TERM=screen-256color tmux -2'
alias tmuxinator='TERM=screen-256color tmuxinator'
alias go_workspace='cd ~/workspace/go'

eval `dircolors ~/.dir_colors/dircolors`

# EXPORTS
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# Miniconda path
export PATH="/home/rafael/miniconda3/bin:$PATH"
# Go PATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/workspace/go
export PATH=$PATH:$GOPATH/bin
export TERM=xterm-256color

# Do menu-driven completion.
zstyle ':completion:*' menu select
#
# # Color completion for some things.
# # http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#
# # formatting and messages
# # http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# .bashrc config:
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# set a fancy prompt (non-color, unless we know we "want" color)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export PATH=~/bin:$PATH
source ~/.purepower
