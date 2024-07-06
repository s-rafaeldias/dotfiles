# vim: ft=bash

# Environment variables
export XDG_CONFIG_HOME="/Users/rafael/.config"
export TERM="xterm-256color"
export COMPLETION_WAITING_DOTS="true"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--layout=reverse"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export PYTHONNOUSERSITE=1
export HOMEBREW_NO_INSTALL_FROM_API=1

export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8


export GPG_TTY=$(tty)

export CC=gcc
export CXX=g++

export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# export DOCKER_BUILDKIT=0
# Remove this if I stop using colima for docker
# export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

export PATH="/opt/homebrew/bin:$PATH"
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/llvm/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/custom-scripts:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/.luarocks/bin:$PATH
export PATH=$HOME/workspace/scripts:$PATH
export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"

export PAGER=/usr/bin/less
export EDITOR='nvim'
. "$HOME/.cargo/env"
