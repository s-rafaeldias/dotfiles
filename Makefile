all: install

update:
	cp -rf ~/.vim/ftplugin .
	cp -rf ~/.vim/.ycm_extra_conf.py .
	cp ~/.vimrc .
	cp ~/.zshrc .
	cp ~/.bashrc .
	cp ~/.tmux.conf .

install:
	cp .vim ~/.
	cp .vimrc ~/.
	cp .zshrc ~/.
	cp .bashrc ~/.
	cp .tmux.conf ~/.

git:
	git add -A
	git commit -m "Backup automático"
	git push -u origin master
