#!/usr/bin/env sh

function systemUpdate () {
	sudo apt update \
		&& sudo apt install -y \
			build-essential \
		cmake \
		curl \
		exuberant-ctags \
		feh \
		fzf \
		gimp \
		git \
		htop \
		imagemagick \
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
		libz-dev libpng-dev \
		lm-sensors \
		nasm \
		nodejs \
		npm \
		ntp \
		podman \
		pkg-config \
		python3-dev \
		ripgrep \
		universal-ctags \
		unzip \
		xclip \
		xorg-dev \
		zip \
		zlib1g-dev \
		zsh \
	    terminator \
	    ruby-dev \
	    yubioath-desktop \
		hsetroot

		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
			/${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

function zshSetup () {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cp zsh/zshrc ~/.zshrc

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

}

function tfSetup(){
	git clone https://github.com/tfutils/tfenv.git ~/.tfenv
	sed -i 's#env bash#env zsh#g' /${HOME}/.tfenv/bin/tfen
}

function pythonSetup(){
	git clone https://github.com/pyenv/pyenv.git /${HOME}/.pyenv
	cd /${HOME}/.pyenv
    src/configure
    make -C src
    git clone https://github.com/pyenv/pyenv-virtualenv.git /${HOME}/.pyenv/plugins/pyenv-virtualenv
}

systemUpdate
zshSetup
tfSetup
pythonSetup
