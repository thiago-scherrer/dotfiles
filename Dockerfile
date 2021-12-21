FROM debian:unstable-slim

ENV USER=root

COPY ./vim/generate.vim /${USER}/.vimrc

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
      curl \
      fzf \
      gcc \
      git \
      golang \
      libncurses5-dev \
      nodejs \
      npm \
      python-dev-is-python3 \
      ripgrep \
      ruby-dev \
      ruby2.7 \
      universal-ctags \
      xclip \
      zsh \
    && cd /tmp \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv  kubectl /bin/kubectl \
    && curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 \
    && chmod +x kops \
    && mv kops /bin/kops \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && cd /tmp \
    && git clone https://github.com/cli/cli \
    && cd cli/cmd/gh \
    && go build \
    && mv gh /bin/ \
    && npm install --global yar \
    && git clone https://github.com/vim/vim \
	  && cd vim \
    && ./configure \
        --disable-netbeans \
        --enable-multibyte \
        --enable-python3interp=yes \
        --enable-rubyinterp=yes \
        --with-features=huge \
        --with-python3-config-dir=$(python3-config --configdir) \
    && make -j3 \
    && make install \
    && npm install -g dockerfile-language-server-nodejs \
    && gem install solargraph \
    && curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim +':silent :PlugInstall --sync' +qa \
    && mkdir -p /${USER}/.config/coc \
    && vim +':silent :CocInstall -sync coc-json coc-html coc-css coc-docker coc-go coc-htmlcoc-json coc-pyright coc-sh coc-solargraph coc-sql coc-tsserver coc-yaml --sync' +qa \
    && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
       && mkdir -p /${USER}/tmp/ \
    && echo 'colorscheme codedark' >> /${USER}/.vimrc

RUN git clone https://github.com/pyenv/pyenv.git /${USER}/.pyenv \
    && cd /${USER}/.pyenv \
    && src/configure \
    && make -C src \
    && git clone https://github.com/tfutils/tfenv.git /${USER}/.tfenv \
    && git clone https://github.com/pyenv/pyenv-virtualenv.git /${USER}/.pyenv/plugins/pyenv-virtualenv \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /${USER}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    && ln -s /usr/local/bin/vim /usr/bin/vim

COPY ./vim/coc-settings.json /${USER}/.vim/coc-settings.json
COPY ./zsh/zshrc /${USER}/.zshrc
COPY ./home/ripgreprc /${USER}/.ripgreprc
COPY ./etc/ntp.conf /etc/ntp.conf

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /root/workspace

CMD [ "zsh" ]
