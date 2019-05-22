all:

vim:
	cp -rf ~/.vim/ftplugin .vim/
	cp ~/.vim/vimrc .vim/

vim-install:
	cp -rf .vim/ ~/

tmux:
	cp ~/.tmux.conf .

zsh:
	cp ~/.zshrc .
	cp ~/.bashrc .

git:
	cp ~/.gitconfig .

backup: vim tmux zsh git
backup-work: vim tmux
