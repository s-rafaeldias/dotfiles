# vim: ft=zsh
# Plugins ============================================
plugins=(
    zsh-z
    taskwarrior
    poetry
    # tmuxinator
    zsh-syntax-highlighting
    vi-mode
    docker
)

# Sources ============================================== {{{
fpath=(~/.zsh/{completion,plugin} $fpath)

source $ZSH/oh-my-zsh.sh

source ~/.zstyles

# Colors for ls
source "$HOME/.local/share/lscolors.sh"

. "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
# eval "$(opam env)"
# [[ ! -r /Users/rafael/.opam/opam-init/init.zsh ]] || source /Users/rafael/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.env ] && source ~/.env
# }}}

# Alias ============================================ {{{
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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Bindkeys ============================================ {{{
bindkey -s '\C-f' '~/.local/bin/rds-tmux-create-session\r'
# }}}

# Functions ============================================ {{{
timer() {
    # https://github.com/trehn/termdown
    # pipx install termdown
    termdown $1; \
        terminal-notifier -message 'Pomodoro' \
        -title 'Work is DONE!' \
        -sound Crystal
}
# }}}
