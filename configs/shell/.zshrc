# vim: ft=bash
# Plugins ============================================
plugins=(
    zsh-z
    taskwarrior
    poetry
    tmuxinator
    zsh-syntax-highlighting
    # vi-mode
    docker
)

# Setups ==============================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.env ] && source ~/.env

fpath=(~/.zsh/{completion,plugin} $fpath)

# Sources ============================================== {{{
source $ZSH/oh-my-zsh.sh

source ~/.zstyles

# Colors for ls
source "$HOME/.local/share/lscolors.sh"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
# }}}

# Alias ============================================ {{{
alias tf='terraform'

alias c='cheat'
alias q='exit'

alias vi='nvim'
alias vim='nvim'

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

alias t='tmuxinator'
alias tm='tmux'
alias tb='tmuxinator start basic'
alias th='tmuxinator start home'
alias d='tmuxinator start dotfiles'

# Taskwarrior + GTD
# alias in='task add +in'
# alias next='task modify -in +next -maybe'
# alias maybe='task modify -in -next +maybe'

alias ca='conda activate $(basename $(pwd))'

alias pywatch='fswatch -o **/*.py | xargs -n1 -I {} make test'
# }}}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Functions ============================================ {{{
# Create basic `.envrc` file for python projects using conda
create_conda_env() {
    envrc_path=$(pwd)/.envrc
    conda_env=$(basename $(pwd))

    conda create -n $conda_env python=3.10 --yes

    cat << EOF >> $envrc_path
# vim: ft=sh
. "$HOME/miniconda3/etc/profile.d/conda.sh"
conda activate $conda_env
EOF
}
alias np='create_conda_env'

timer() {
    # https://github.com/trehn/termdown
    # pipx install termdown
    termdown $1; \
        terminal-notifier -message 'Pomodoro' \
        -title 'Work is DONE!' \
        -sound Crystal
}

docker-setup() {
    colima start
    pushd ~/workspace/projects/docker-images/
    make start
    popd
}

alias ds='docker-setup'
# }}}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate base
