#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
ERROR_MSG="[${RED}ERROR${NC}]"
SUCCESS_MSG="[${GREEN}SUCCESS${NC}]"

backup() {
	# git
	cp ~/.gitmessage .
	cp ~/.gitconfig ./.gitconfig_$1

	# nvim
	rsync -r -aqz --exclude 'plugged' --links ~/.config/nvim/ .config/nvim/

	# vim
	rsync -r --exclude 'bundle' --links ~/.vim/ .vim/

	# tmux
	cp ~/.tmux.conf .

	# tmuxinator
	rsync -r --links ~/.config/tmuxinator .config/

	# shell (zshrc and bashrc)
	cp ~/.zshrc ~/.bashrc ~/.purepower .

	# Lein (clojure)
	rsync -r --links ~/.lein .
}

restore() {
	# .config
	cp .config ~/ -r

	# lein
	cp .lein ~/ -r

	# shell
	cp .zshrc .bashrc .purepower ~/
}

