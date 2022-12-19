#!/usr/bin/env bash
set -e

function basicSetup () {
	pkg update
	pkg install \
		gh \
		gnupg \
		golang \
		kubectl \
		nodejs-lts \
		python \
		ripgrep \
	&& npm install --global yar
}

function terraformSetup () {
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
}

function pythonSetup () {
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    	cd ~/.pyenv
    	src/configure
    	make -C src
    	git clone https://github.com/pyenv/pyenv-virtualenv.git \
		~/.pyenv/plugins/pyenv-virtualenv

	pip install flake8
	pip install --upgrade pip
}

function ohMyZshSetup () {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
		~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

	git clone https://github.com/zsh-users/zsh-autosuggestions.git \
		~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

	cp zsh/zshrc ~/.zshrc
}

basicSetup
terraformSetup
pythonSetup
ohMyZshSetup
