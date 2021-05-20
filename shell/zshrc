# User settings ======================================
export ZSH=$HOME/.oh-my-zsh

# Plugins ============================================
plugins=(
	docker
	git
	# kubectl
	rbenv
	tmuxinator
	# zsh-autosuggestions
	zsh-syntax-highlighting
	poetry
)

# Theme ==============================================
#POWERLEVEL9k Config
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'
COMPLETION_WAITING_DOTS="true"

# Setups ==============================================
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rafael/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rafael/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rafael/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rafael/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/rafael/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

fpath=(~/.zsh.d/ $fpath)


# Sources ==============================================
source ~/.exports
source ~/.alias
source $ZSH/oh-my-zsh.sh
source ~/.zstyles
source ~/.completions/*
source ~/.env
