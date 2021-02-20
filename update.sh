#!/bin/bash

for i in $(find ~/.vim -type d | grep -v .git | sort -n | uniq)
do
	cd $i
	git fetch
	git rebase
done


for i in $(find ~/.oh-my-zsh -type d | grep -v .git | sort -n | uniq)
do
	cd $i
	git fetch
	git rebase
done
