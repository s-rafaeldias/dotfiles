# User settings ======================================
export ZSH="/home/05018601183/.oh-my-zsh"

# Plugins ============================================
plugins=(
  git
  zsh-syntax-highlighting
  docker
  kubectl
  tmuxinator
)

# Theme ==============================================
#POWERLEVEL9k Config
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=""
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir newline vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator dir_writable go_version anaconda rbenv)

COMPLETION_WAITING_DOTS="true"


# PATH ===============================================
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:/bin/lein
export TERM=xterm-256color
export PATH=~/bin:$PATH

# ALIAS ==============================================
alias zshconfig="nvim ~/.zshrc"
alias source_zsh="source ~/.zshrc"

alias vimconfig="nvim ~/.config/nvim/init.vim"

alias tmux='TERM=screen-256color tmux -2'
alias tmuxinator='TERM=screen-256color tmuxinator'

alias ssh_eqana_prod="ssh EQANA@SRVANALYTIC01"
alias ssh_eu_prod="ssh 05018601116@poupex.com.br@SRVANALYTIC01"
alias update="sudo apt update && sudo apt upgrade -y"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  ZSH_THEME="agnoster"
else
  export EDITOR='nvim'
fi


source $ZSH/oh-my-zsh.sh

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
source ~/.purepower
