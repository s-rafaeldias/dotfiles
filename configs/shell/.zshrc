# vim: ft=zsh

# zmodload zsh/zprof # Debug time info

# Inital setup {{{
bindkey -e
# }}}

# History {{{
export HISTSIZE=100000
export SAVEHIST=100000
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

bindkey '^[[A' up-line-or-beginning-search   # Up
bindkey '^[[B' down-line-or-beginning-search # Down
# }}}

# Sources {{{
source ~/.zstyles

# Colors for ls
source "$HOME/.local/share/lscolors.sh"

source "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f ~/.env ] && source ~/.env
# }}}

# Plugins {{{
# TODO: install plugin if it doesn't exists
[ -f ~/.zsh/plugin/zsh-z/zsh-z.plugin.zsh ] && source ~/.zsh/plugin/zsh-z/zsh-z.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# Alias {{{
alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'

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

alias inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'

alias ls='gls --color=auto'
alias l='ls -alFh'
alias la='ls -Ah'
alias ll='ls -CFh'

alias nnn='nnn -H -d -i'
alias n='pnpm'

# alias t='tmuxinator'
alias tx='tmux'
alias tb='tmuxinator start basic'
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

alias ports='lsof -iTCP -sTCP:LISTEN -P -n'

# }}}

# Bindkeys {{{
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

# Completion {{{
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit

complete -C '/usr/local/bin/aws_completer' aws
# }}}

# zprof # Debug time info
