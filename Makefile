all:

vim:
	cp -rf ~/.vim/ftplugin .vim/
	cp ~/.vimrc .vim/

vim-install:
	cp -rf .vim/.vimrc ~/
	cp -rf .vim/ ~/
	rm -rf ~/.vim/.vimrc

tmux:
	cp ~/.tmux.conf .

zsh:
	cp ~/.zshrc .
	cp ~/.bashrc .

git:
	cp ~/.gitconfig .

backup: vim tmux zsh git
backup-work: vim tmux
