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
		py3-pip \
		ripgrep \
		ruby \
		ruby-dev \
		xclip \
		zsh

	npm install --global yar

	git clone https://github.com/kubernetes/kops.git
	cd kops/cmd/kops
	go build -o /bin/kops
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

    mkdir -p /${USER}/.config/coc

    vim +':silent :CocInstall -sync coc-json coc-html coc-css coc-docker coc-go coc-htmlcoc-json coc-pyright coc-sh coc-solargraph coc-sql coc-tsserver coc-yaml --sync' +qa

    echo 'colorscheme codedark' >> /${USER}/.vimrc

    ln -s /usr/local/bin/vim /usr/bin/vim
}

function terraformSetup () {
    git clone https://github.com/tfutils/tfenv.git /${USER}/.tfenv
	sed -i 's#env bash#env zsh#g' /${USER}/.tfenv/bin/tfenv
}

function pythonSetup () {
	init

	git clone https://github.com/pyenv/pyenv.git /${USER}/.pyenv
    cd /${USER}/.pyenv
	sed -i 's#env bash#env zsh#g' src/configure
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
}

basicSetup
vimSetup
terraformSetup
pythonSetup
ohMyZshSetup
