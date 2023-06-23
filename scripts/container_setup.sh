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
		bash \
		bind-tools \
		ctags \
		curl \
		fzf \
		gpg \
		gpg-agent \
		gcc \
		git \
		go \
		jq \
		make \
		musl-dev \
		ncurses \
		ncurses-dev \
		nodejs \
		npm \
		nmap \
		openssl \
		openssh-client \
		py3-pip \
		perl \
		python3-dev \
		ripgrep \
		ruby \
		ruby-dev \
		xclip \
		yarn \
		zsh \
		zip

	npm install --global yar

	git clone https://github.com/cli/cli && cd cli && make install
	ln -s -f /usr/local/bin/gh /usr/bin/gh

	go install github.com/xo/usql@master

}

function vimSetup () {
	init

	git clone https://github.com/vim/vim
	cd vim
        ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-luainterp \
            --enable-cscope \
            --enable-gui=auto \
            --enable-gtk2-check \
            --with-compiledby="j.jith"
   	make -j8
    	make install

    npm i -g dockerfile-language-server-nodejs
    npm i -g graphql-language-service-cli

    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim +':silent :PlugInstall --sync' +qa

    mkdir -p /${USER}/tmp/
    mkdir -p /${USER}/.vim/sessions/

    mkdir -p /${USER}/.config/coc

    vim +':silent :CocInstall -sync \
		coc-css \
		coc-docker \
		coc-go \
		coc-html \
		coc-htmlcoc-json \
		coc-jedi \
		coc-json \
		coc-markdownlint \
		coc-pyright \
		coc-sh \
		coc-sql \
		coc-tsserver \
		--sync' +qa

    cat /opt/vim_post_install >> /${USER}/.vimrc
    rm /opt/vim_post_install

    ln -s /usr/local/bin/vim /usr/bin/vim

    go install github.com/hashicorp/terraform-ls@latest
    go install golang.org/x/tools/gopls@latest
}

function terraformSetup () {
    git clone https://github.com/tfutils/tfenv.git /${USER}/.tfenv
	go install github.com/terraform-docs/terraform-docs@latest

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

function gcloudSetup () {
	curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
	&& mkdir -p /usr/local/gcloud \
	&& tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
	&& /usr/local/gcloud/google-cloud-sdk/install.sh \
	&& /usr/local/gcloud/google-cloud-sdk/bin/gcloud --quiet components install gke-gcloud-auth-plugin kubectl alpha beta \
	&& pip3 install grpcio
}

function k8s () {
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

	helm plugin install https://github.com/quintush/helm-unittest

	ln -s /usr/local/gcloud/google-cloud-sdk/bin/kubectl /bin/kubectl

	git clone https://github.com/derailed/k9s.git \
	&& cd k9s && go install && cd .. && rm -rfv k9s

	git clone https://github.com/ahmetb/kubectx /opt/kubectx \
	&& ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx \
	&& ln -s /opt/kubectx/kubens /usr/local/bin/kubens \
	&& mkdir -p ~/.oh-my-zsh/completions \
	&& chmod -R 755 ~/.oh-my-zsh/completions \
	&& ln -s /opt/kubectx/completion/_kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh \
	&& ln -s /opt/kubectx/completion/_kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh
}

function awsInstall () {
	export AWS_CLI_VER=2.1.39

	apk add --no-cache gcompat \
	&& curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip -o awscliv2.zip \
	&& unzip awscliv2.zip \
	&& ./aws/install \
	&& rm awscliv2.zip
}

echo '#### basicSetup start ####'
basicSetup > /dev/null 2>&1

echo '#### vimSetup start ####'
vimSetup > /dev/null 2>&1

echo '#### terraformSetup start ####'
terraformSetup > /dev/null 2>&1

echo '#### pythonSetup start ####'
pythonSetup > /dev/null 2>&1

echo '#### ohMyZshSetup start ####'
ohMyZshSetup > /dev/null 2>&1

echo '#### gcloudSetup start ####'
gcloudSetup > /dev/null 2>&1

echo '#### k8s start ####'
k8s > /dev/null 2>&1

echo '#### awsInstall start ####'
awsInstall > /dev/null 2>&1
