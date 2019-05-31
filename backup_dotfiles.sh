#!/bin/bash

# Input do ambiente (home ou work)
ambiente=$1
echo "Backup do ambiente $ambiente"

git checkout $ambiente

# Git backup
echo Backing up git configs
if cp ~/.gitconfig git/ ; then
	echo GG
else
	echo Erro ao fazer backup das configurações do git
fi

# Vim backup
echo Backing up vim configs
rsync -r --exclude 'bundle' --links ~/.vim/ vim/

# Oh my zsh backup
echo Backing up shell configs
cp ~/.zshrc ~/.bashrc shell

