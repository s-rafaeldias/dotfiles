# vim: ft=zsh

zmodload zsh/zprof # Debug time info

# History {{{
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS     # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
setopt HIST_IGNORE_DUPS         # do not save duplicated command
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt HIST_FIND_NO_DUPS        # don't show dups
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY         # record command start time

bindkey '^R' history-incremental-search-backward

# Setup arrows for quick history search (https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search   # Up
bindkey "^[[B" down-line-or-beginning-search # Down
# }}}

# Completion {{{
autoload -U compinit && compinit
# }}}

# Sources {{{
source ~/.zstyles

# Colors for ls
source "$HOME/.local/share/lscolors.sh"

source "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
# eval "$(opam env)"
# [[ ! -r /Users/rafael/.opam/opam-init/init.zsh ]] || source /Users/rafael/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.env ] && source ~/.env
# }}}

# Alias {{{
alias tf='terraform'
alias q='exit'
alias j='just'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias k='kubectl'
alias br='brew uninstall'
alias bi='brew install'
alias bu='brew upgrade'
alias bb='brew bundle --file=$HOME/.dotfiles/Brewfile'
alias bv='brew uninstall neovim && brew install neovim --HEAD'

# Disable for now. One day I want to go back to NixOS
# alias he='home-manager edit'
# alias hg='home-manager generations'
# alias hp='home-manager packages'
# alias hs='home-manager switch'
# alias hu='nix-channel --update && home-manager switch'

alias inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'

alias ls='gls --color=auto'
alias l='ls -alFh'
alias la='ls -Ah'
alias ll='ls -CFh'

alias nnn='nnn -H -d -i'
alias n='pnpm'

# alias t='tmuxinator'
alias tm='tmux'
alias tb='tmuxinator start basic'
# First deactivate conda env to make sure
# `pip` will use the correct bin (from current activated env)
# https://github.com/conda/conda/issues/7173#issuecomment-1053848539
alias t='tmuxinator start home'
alias d='tmuxinator start dotfiles'

# Git alias
alias gst='git status'
alias gcb='git checkout -b'
alias gsb='git switch'
alias gcm='git checkout main'
alias gp='git pull'
alias gps='git push'
alias grm='git rebase --interactive main'

# alias ca='conda activate $(basename $(pwd))'
alias np='rds-setup-python-env'
alias python='python3'
alias p='python'

alias pywatch='fswatch -o **/*.py | xargs -n1 -I {} make test'
alias pyig='wget https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore -O .gitignore'

# }}}

# Bindkeys {{{
bindkey -e

bindkey -s '\C-f' '~/.local/bin/rds-tmux-create-session\r'
# }}}

# Functions {{{
timer() {
    # https://github.com/trehn/termdown
    # pipx install termdown
    termdown $1; \
        terminal-notifier -message 'Pomodoro' \
        -title 'Work is DONE!' \
        -sound Crystal
}
# }}}

# TODO: do I really care for highlighting? Let's see after a few weeks...
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zprof # Debug time info
