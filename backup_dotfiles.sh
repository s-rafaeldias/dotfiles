#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Input do ambiente (home ou work)
ambiente=$1
echo "Backup do ambiente $ambiente"

git checkout $ambiente

# Git backup
if cp ~/.gitconfig ~/.gitmessage git/ ; then
	echo -e "${GREEN}GG${NC} do git"
else
	echo -e "${RED}ERROR${NC} do git"
fi

# Vim backup
echo Backing up vim configs
rsync -r --exclude 'bundle' --links ~/.vim/ vim/

# Oh my zsh backup
echo Backing up shell configs
cp ~/.zshrc ~/.bashrc shell

