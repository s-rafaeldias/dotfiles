#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc)

for file in "${files_to_save[@]}"
do
	cp -r $file .
done
	
date=date+"%c"

git add -A
git commit -m "Backup de $date"
git push -u origin master
