all:

vim:
	cp -rf ~/.vim/ftplugin .vim/
	cp -rf ~/.vim/.ycm_extra_conf.py .vim/
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

backup: vim tmux zsh
backup-work: vim tmux
