#!/bin/bash

function scan () {
	for list in $(cat scam.txt)
	do
		git clone $list
	done
}

function salus () {
	docker run --rm -t -v $(pwd):/home/repo coinbase/salus
}

scan
salus
