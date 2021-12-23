FROM alpine:latest

ENV USER=root

COPY ./vim/generate.vim /${USER}/.vimrc
COPY ./scripts/container_setup.sh /bin/container_setup.sh

RUN container_setup.sh

COPY ./vim/coc-settings.json /${USER}/.vim/coc-settings.json
COPY ./zsh/zshrc /${USER}/.zshrc
COPY ./home/ripgreprc /${USER}/.ripgreprc
COPY ./etc/ntp.conf /etc/ntp.conf

WORKDIR /root/workspace

CMD [ "zsh" ]
