# vim: ft=bash

# Environment variables
export TERM="xterm-256color"
export COMPLETION_WAITING_DOTS="true"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export PYTHONNOUSERSITE=1
export HOMEBREW_NO_INSTALL_FROM_API=1

export PAGER=/usr/bin/less

export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8

export CC=gcc
export CXX=g++

export DOCKER_BUILDKIT=0

export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/llvm/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/custom-scripts:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/.luarocks/bin:$PATH
export PATH=$HOME/workspace/scripts:$PATH

export EDITOR='nvim'

# export ZK_NOTEBOOK_DIR=$HOME/workspace/zk/
