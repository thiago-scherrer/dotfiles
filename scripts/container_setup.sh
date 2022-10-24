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
		github-cli \
		go \
		jq \
		make \
		musl-dev \
		ncurses \
		ncurses-dev \
		nodejs \
		npm \
		openssh-client \
		py3-pip \
		ripgrep \
		ruby \
		ruby-dev \
		xclip \
		yarn \
		zsh \
		zip

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

    go install golang.org/x/tools/gopls@latest

    /usr/local/bin/vim +':silent :PlugInstall --sync' +qa

    mkdir -p /${USER}/tmp/


    mkdir -p /${USER}/.config/coc

    /usr/local/bin/vim +':silent :CocInstall -sync coc-jedi coc-json coc-html coc-css coc-docker coc-go coc-htmlcoc-json coc-pyright coc-sh coc-solargraph coc-sql coc-tsserver --sync' +qa

    cat /opt/vim_post_install >> /${USER}/.vimrc
    rm /opt/vim_post_install

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

function gcloudSetup () {
	curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
	&& mkdir -p /usr/local/gcloud \
	&& tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
	&& /usr/local/gcloud/google-cloud-sdk/install.sh \
	&& /usr/local/gcloud/google-cloud-sdk/bin/gcloud --quiet components install gke-gcloud-auth-plugin kubectl alpha beta \
	&& pip3 install grpcio

	ln -s /usr/local/gcloud/google-cloud-sdk/bin/kubectl /bin/kubectl
}

function k8s () {
	export VERIFY_CHECKSUM=false
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

	helm plugin install https://github.com/quintush/helm-unittest

	git clone https://github.com/derailed/k9s.git \
	&& cd k9s && go install && cd .. && rm -rfv k9s

	git clone https://github.com/ahmetb/kubectx /opt/kubectx \
	&& ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx \
	&& ln -s /opt/kubectx/kubens /usr/local/bin/kubens \
	&& mkdir -p ~/.oh-my-zsh/completions \
	&& chmod -R 755 ~/.oh-my-zsh/completions \
	&& ln -s /opt/kubectx/completion/_kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh \
	&& ln -s /opt/kubectx/completion/_kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh

	export istio_version=1.14.1

	wget https://github.com/istio/istio/releases/download/${istio_version}/istioctl-${istio_version}-linux-amd64.tar.gz  \
	&& tar -C /bin/ -xvf istioctl-${istio_version}-linux-amd64.tar.gz \
	&& rm -f istioctl-${istio_version}-linux-amd64.tar.gz

	(
	  set -x; cd "$(mktemp -d)" &&
	  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
	  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
	  KREW="krew-${OS}_${ARCH}" &&
	  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
	  tar zxvf "${KREW}.tar.gz" &&
	  ./"${KREW}" install krew
	)
	~/.krew/bin/kubectl-krew install tree
}

function awsInstall () {
	export AWS_CLI_VER=2.1.39

	apk add --no-cache gcompat \
	&& curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip -o awscliv2.zip \
	&& unzip awscliv2.zip \
	&& ./aws/install \
	&& rm awscliv2.zip
}

basicSetup
terraformSetup
pythonSetup
ohMyZshSetup
gcloudSetup
k8s
awsInstall
vimSetup
