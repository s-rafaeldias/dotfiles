#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc)

for file in "${files_to_save[@]}"
do
	cp -r $file .
done
	
git add -A
git commit -m "Backup automático"
git push -u origin master
