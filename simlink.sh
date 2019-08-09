#!/bin/bash
# Shell files
for f in ../shell/*; do
	file=$(basename "$f")
	ln -sf ~/dotfiles/shell/$file ~/.$file
done

# Nvim files
ln -sf ~/dotfiles/vim/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

# tmux files
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
