#!/bin/bash
WORK_DIR=$(basename $(pwd))
# Shell files
for f in ./shell/*; do
	file=$(basename "$f")
	ln -sf ~/$WORK_DIR/shell/$file ~/.$file
done

# Ranger files
for f in ./ranger/*; do
	file=$(basename "$f")
	ln -sf ~/$WORK_DIR/ranger/$file ~/.config/ranger/$file
done

# Nvim files
for f in ./nvim/languages/*.*; do
	file=$(basename "$f")
	ln -sf ~/$WORK_DIR/nvim/languages/$file ~/.config/nvim/languages/$file
done
for f in ./nvim/*.*; do
	file=$(basename "$f")
	echo $file
	ln -sf ~/$WORK_DIR/nvim/$file ~/.config/nvim/$file
done

# tmux/tmuxinator files
ln -sf ~/$WORK_DIR/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/$WORK_DIR/completions/tmuxinator.zsh ~/.completions/tmuxinator.zsh

# Lein settings
ln -sf ~/$WORK_DIR/lein/profiles.clj ~/.lein/profiles.clj

# Git settings
ln -sf ~/$WORK_DIR/git/.gitmessage  ~/.gitmessage
ln -sf ~/$WORK_DIR/completions/git-flow.zsh ~/.completions/git-flow.zsh

# Pip
ln -sf ~/$WORK_DIR/completions/pip.zsh ~/.completions/pip.zsh

# Emacs
ln -sf ~/$WORK_DIR/emacs/init.el ~/.emacs.d/init.el
ln -sf ~/$WORK_DIR/emacs/config.org ~/.emacs.d/config.org

