# vim: ft=bash

# Environment variables
export XDG_CONFIG_HOME="/Users/rafael/.config"
export TERM="xterm-256color"
export COMPLETION_WAITING_DOTS="true"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--layout=reverse"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export SDKMAN_DIR="$HOME/.sdkman"

export PYTHONNOUSERSITE=1
export HOMEBREW_NO_INSTALL_FROM_API=1

export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8

export GPG_TTY=$(tty)

export CC=gcc
export CXX=g++

export BUN_INSTALL="$HOME/.bun"
export PHP_INI_SCAN_DIR="/Users/rafael/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

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
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Users/rafael/.config/herd-lite/bin:$PATH"
# export PATH="$HOME/.local/share/mise/shims:$PATH"
# export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"

export PAGER=/usr/bin/less
export EDITOR='nvim'
source "$HOME/.cargo/env"
