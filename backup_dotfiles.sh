#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc)

for file in "${files_to_save[@]}"
do
	cp -r $file .
done
	
date='America/Sao_Paulo' date

git add -A
git commit -m "Backup de ${date}"
git push -u origin master
