#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc)

for file in "${files_to_save[@]}"
do
	cp -r $file .
done
	
data=date +"%c"

git add -A
git commit -m "Backup de $data"
git push -u origin master
