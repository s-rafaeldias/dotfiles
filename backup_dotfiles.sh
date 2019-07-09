#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
ERROR_MSG="[${RED}ERROR${NC}]"
SUCCESS_MSG="[${GREEN}SUCCESS${NC}]"

backup() {
	echo -e "Qual ambiente?\n[1] Personal\n[2] Work"
	read ambiente

	if [[ $ambiente == 1 ]]; then
		cp ~/.gitconfig ./.gitconfig_personal
	else
		cp ~/.gitconfig ./.gitconfig_work
	fi

	# git
	cp ~/.gitmessage .

	# nvim
	rsync -r -aqz --exclude 'plugged' --links ~/.config/nvim/ .config/nvim/

	# vim
	#rsync -r --exclude 'bundle' --links ~/.vim/ .vim/

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

echo -e "O que vc gostaria de fazer?\n[1] - Backup\n[2] - Restore\n"
read option

if [[ $option == 1 ]];then
	backup
else
	restore
fi

