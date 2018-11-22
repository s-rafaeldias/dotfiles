#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc ~/.vim)

for file in "${files_to_save[@]}"
do
	echo "Copying $file"
	cp -r $file .
done
	
git add -A
git commit -m "Backup automático"
git push -u origin master
