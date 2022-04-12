#!/usr/bin/env sh
set -e

function init () {
	cd /tmp/
	rm -rf /tmp/*
}

function basicSetup () {
	init

	apk update
	apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
		aws-cli \
		bash \
		ctags \
		curl \
		fzf \
		gpg \
		gpg-agent \
		gcc \
		git \
		github-cli \
		go \
		kubectl \
		make \
		musl-dev \
		ncurses-dev \
		nodejs \
		npm \
		openssh-client \
		py3-pip \
		ripgrep \
		ruby \
		ruby-dev \
		xclip \
		zsh

	npm install --global yar
}

function vimSetup () {
	init

	git clone https://github.com/vim/vim
	cd vim
    ./configure \
		--disable-netbeans \
        --enable-multibyte \
        --enable-python3interp=yes \
        --enable-rubyinterp=yes \
        --with-features=huge \
        --with-python3-config-dir=$(python3-config --configdir)

    make -j4
    make install

    npm install -g dockerfile-language-server-nodejs

    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +':silent :PlugInstall --sync' +qa

	mkdir -p /${USER}/tmp/

	go get golang.org/x/tools/gopls@latest

    mkdir -p /${USER}/.config/coc

    vim +':silent :CocInstall -sync coc-json coc-html coc-css coc-docker coc-go coc-htmlcoc-json coc-pyright coc-sh coc-solargraph coc-sql coc-tsserver coc-yaml --sync' +qa

    ln -s /usr/local/bin/vim /usr/bin/vim
}

function terraformSetup () {
    git clone https://github.com/tfutils/tfenv.git /${USER}/.tfenv
}

function pythonSetup () {
	init

	git clone https://github.com/pyenv/pyenv.git /${USER}/.pyenv
    cd /${USER}/.pyenv
    src/configure
    make -C src
    git clone https://github.com/pyenv/pyenv-virtualenv.git \
		/${USER}/.pyenv/plugins/pyenv-virtualenv

	pip install flake8
}

function ohMyZshSetup () {
	init

	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
		/${USER}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

	git clone https://github.com/zsh-users/zsh-autosuggestions \
		${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

basicSetup
vimSetup
terraformSetup
pythonSetup
ohMyZshSetup
