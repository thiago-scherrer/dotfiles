#!/bin/bash

function systemUpdate() {
	su -c '
		pacman -Syu \
		&& pacman -S \
			TDM \
			cmake \
			community/prusa-slicer \
			cron \
			curl \
			dmenu \
			dunst \
			extra/noto-fonts-extra \
			firefox \
			fzf \
			gcc \
			git \
			github-cli \
			htop \
			i3-wm \
			imagemagick \
			ipython3 \
			libgtk \
			libncurses
			light \
			lightdm \
			lightdm-gtk-greeter \
			lxappearance \
			lxappearance-obconf \
			lxdm \
			make \
			nasm \
			ncurses \
			nitrogen \
			node \
			npm \
			ntfs-3g \
			ntp \
			openvpn \
			pavucontrol \
			pcsc-tools \
			pcscd \
			pcsclite \
			powerline \
			pulseaudio \
			python-pip \
			python-pipenv \
			python-pipenv-to-requirements \
			python3 \
			python3-config \
			ranger \
			reflector \
			rg \
			ruby \
			terminator \
			viewnior \
			xclip \
			xorg-server \
			xterm \
			yarn \
			yubikey-manager-qt \
			yubioath-desktop \
			zip \
		&& npm install --global yar \
		&& systemctl enable cronie.service \
		&& systemctl enable lightdm \
		&& touch /etc/ntp.conf \
		&& ntpd -q -g \
		&& cp ntp/ntp.conf /etc/ntp.conf \
		&& ntpd -q -g \
		&& ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
		&& cp cron/cron /var/spool/cron/root
	'
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
	su -c  'pacman -R vi*'
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
	curl https://pyenv.run | bash
}

systemUpdate
zshSetup
vimSetup
tfSetup
installPython
