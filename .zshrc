# User settings ======================================
if [[ $USER == 'rafael' ]]; then
	export ZSH=/home/rafael/.oh-my-zsh
	eval `dircolors ~/.dir_colors/dircolors`
else
	export ZSH="/home/05018601183/.oh-my-zsh"
fi

# Plugins ============================================
plugins=(
	docker
	kubectl
	tmuxinator
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Theme ==============================================
#POWERLEVEL9k Config
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
COMPLETION_WAITING_DOTS="true"


# PATH ===============================================
if [[ $USER == 'rafael' ]]; then
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
else
	export PATH=$PATH:/usr/local/go/bin
	export GOPATH=$HOME/go
	export PATH=$PATH:/bin/lein
	export TERM=xterm-256color
	export PATH=~/bin:$PATH
fi


# ALIAS ==============================================
alias zshconfig="nvim ~/.zshrc"
alias source_zsh="source ~/.zshrc"
alias vimconfig="nvim ~/.config/nvim/init.vim"
alias tmux='TERM=screen-256color tmux -2'
alias tmuxinator='TERM=screen-256color tmuxinator'
alias update="sudo apt update && sudo apt upgrade -y"

if [[ $USER == 'rafael' ]]; then
	alias go_workspace='cd ~/workspace/go'
else
	alias ssh_eqana_prod="ssh EQANA@SRVANALYTIC01"
	alias ssh_eu_prod="ssh 05018601116@poupex.com.br@SRVANALYTIC01"
fi

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
