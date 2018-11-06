#!/bin/bash

files_to_save=(~/.vimrc ~/.zshrc)

for file in "${files_to_save[@]}"
do
	cp -r $file .
done
	
date='America/Sao_Paulo' date
commit_msg="Backup de "
commit_msg+=$date

git add -A
git commit -m "$commit_msg"
git push -u origin master
