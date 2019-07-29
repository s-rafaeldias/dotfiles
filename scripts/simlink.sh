#!/bin/bash
for f in ../shell/*; do
	file=$(basename "$f")
	ln -sf ~/dotfiles/shell/$file ~/.$file
done
