#!/bin/bash

function systemUpdate() {
	su -c '
		apt update \
		&& apt install -y \
			build-essential \
		cmake \
		curl \
		evince \
		exuberant-ctags \
		feh \
		fzf \
		gimp \
		git \
		htop \
		imagemagick \
		irssi \
		libavcodec-extra \
		libboost-all-dev \
		libboost-dev \
		libboost-filesystem-dev \
		libboost-filesystem-dev \
		libboost-iostreams-dev \
		libboost-locale-dev \
		libboost-log-dev \
		libboost-regex-dev \
		libboost-thread-dev \
		libcereal-dev \
		libcurl4-openssl-dev \
		libdbus-1-dev \
		libeigen3-dev \
		libfreetype-dev \
		libgmpxx4ldbl \
		libgtk-3-dev \
		libgtk2.0-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libnlopt-cxx-dev \
		libnlopt-dev \
		libopenvdb-dev \
		libsdl2-dev \
		libtbb-dev \
		libudev-dev \
		libwxgtk3.0-gtk3-dev \
		libz-dev libpng-dev \
		lm-sensors \
		nasm \
		nodejs \
		npm \
		openvpn \
		pkg-config \
		python3-dev \
		ranger \
		ripgrep \
		universal-ctags \
		unzip \
		x11-apps \
		xclip \
		xfce4-screenshooter \
		xorg-dev \
		zip \
		zlib1g-dev \
		zsh \
	    terminator \
	    ruby2.7 \
	    ruby-dev \
	    yubioath-desktop \
		hsetroot \
	    && npm install --global yar \
	    && rm /usr/share/vim/vim82/ -rfv \
	    && ln -s /usr/local/share/vim/vim82/ /usr/share/vim/'

	cp .gitconfig ~/
}

function zshSetup () {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cp zsh/.zshrc ~/

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

}

function vimSetup () {
	mkdir -p ~/tmp

	git clone https://github.com/vim/vim vim_tmp
	cd vim_tmp
	su -c  'apt remove -y vi*'
	export VIMRUNTIMEDIR=/usr/share/vim/vim82
	./configure --with-features=huge \
		--enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-python3interp=yes \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
		--enable-terminal
	make -j2
	su -c 'make install'

	su -c 'npm install -g dockerfile-language-server-nodejs'
	su -c 'gem install solargraph'

	vim -c 'CocInstall -sync coc-json coc-html coc-css coc-docker coc-go coc-htmlcoc-json coc-pyright coc-sh coc-solargraph coc-sql coc-tsserver coc-yaml |q'

	cd ..
	rm -rf vim_tmp
	cp vim/.vimrc ~/.vimrc
}

function tfSetup(){
	git clone https://github.com/tfutils/tfenv.git ~/.tfenv
}


function importConfig () {
	cp -rvT home ~/
	cp -rvT config ~/.config/
}

function installPython () {
	pip install flake8
	curl https://pyenv.run | bash
}

systemUpdate
zshSetup
vimSetup
tfSetup
installPython
