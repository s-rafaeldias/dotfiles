#!/bin/bash
for f in ../shell/*; do
	if [[ -f $f ]]; then
		echo $f
		# ln -sf $HOME/$f $HOME/dotfiles/shell/$f
	fi
done
