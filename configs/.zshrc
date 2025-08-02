# vim: ft=zsh

# This is my zsh setup
# Some references I used to build this:
# https://github.com/mrnugget/dotfiles/blob/6615bd6167d183eeba09be5374fa4bde1d63e624/zshrc

# zmodload zsh/zprof # Debug time info

# Inital setup {{{
bindkey -e
# }}}

# History {{{
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS     # delete old entry if new is duped
setopt HIST_IGNORE_DUPS         # do not save duplicated command
setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt HIST_FIND_NO_DUPS        # don't show dups
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution

setopt share_history

# }}}

# Completion {{{
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Add completions installed through Homebrew packages
# See: https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

complete -C '/usr/local/bin/aws_completer' aws

setopt always_to_end
setopt auto_pushd

source ~/.zstyles
# }}}

# Sources {{{

# Colors for ls
source "$HOME/.local/share/lscolors.sh"

source "$HOME/.cargo/env"

# eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

eval "$(mise activate)"

[ -f ~/.env ] && source ~/.env
# }}}

# Key bindings {{{
bindkey -s '\C-f' '~/.local/bin/rds-tmux-create-session\n'

# CTRL-R for history search
bindkey '^R' history-incremental-search-backward
# CTRL-S for search forward in history
bindkey '^S' history-incremental-search-forward
# CTRL-Y for selecting search without executing it
bindkey '^Y' accept-search

# Setup arrows for quick history search (https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search   # Up
bindkey '^[[B' down-line-or-beginning-search # Down
# }}}

# Plugins {{{
# TODO: install plugin if it doesn't exists
[ -f ~/.zsh/plugin/zsh-z/zsh-z.plugin.zsh ] && source ~/.zsh/plugin/zsh-z/zsh-z.plugin.zsh

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# Alias {{{
alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'

alias r='bin/rails'

alias tf='terraform'
alias q='exit'
alias j='just'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias k='kubectl'
alias br='brew uninstall'
# alias bi='brew install'
# Save all libs I install via Brew so I can review later if I want to move them
# to `Brewfile`
bi() {
    echo $@ >> /Users/rafael/.dotfiles/Brewfile_new
    brew install $@
}

alias bu='brew upgrade'
alias bv='rm -rf /Users/rafael/Library/Caches/Homebrew/neovim--git && brew uninstall neovim && brew install neovim --HEAD'

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
alias ga='git add -A -p'
alias gc='git commit'
alias gst='git status'
alias gp='git pull'
alias gps='git push'
alias grb='git rebase --interactive main'

# alias ca='conda activate $(basename $(pwd))'
alias np='rds-setup-python-env'
alias python='python3'
alias p='python'

alias pywatch='fswatch -o **/*.py | xargs -n1 -I {} make test'

# TODO: create a fzf extension to create/clone .gitignore files
alias pyig='wget https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore -O .gitignore'

alias ports='lsof -iTCP -sTCP:LISTEN -P -n'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
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

# Prompt {{{
# Ref: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# alternative ref: https://zsh-manual.netlify.app/prompt-expansion
# what info I want?
# - path (how much of the path?)
# - add new line after execution (Do I really care?)
# - anything else?
# dir_info="%(5~|%-1~/.../%2~|%4~) %% "
# Do I care enough to not show the full path?
dir_info="%~ %% "
export PROMPT="%n @ $dir_info"
# }}}

# zprof # Debug time info

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
