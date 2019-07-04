#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

ERROR_MSG="[${RED}ERROR${NC}]"
SUCCESS_MSG="[${GREEN}SUCCESS${NC}]"

# Input do ambiente (home ou work)
ambiente=$1
echo "Backup do ambiente $ambiente"

git checkout $ambiente

# git
cp ~/.gitmessage .
cp ~/.gitconfig .

# nvim
rsync -r -aqz --exclude 'plugged' --links ~/.config/nvim/ .config/nvim/

# vim
rsync -r --exclude 'bundle' --links ~/.vim/ .vim/

# tmux
cp ~/.tmux.conf .

# tmuxinator
rsync -r --links ~/.config/tmuxinator .config/tmuxinator

# shell (zshrc and bashrc)
cp ~/.zshrc ~/.zsh_profile ~/.bashrc ~/.bash_profile ~/.purepower .
