FROM alpine:latest

ENV USER=root

COPY ./vim/generate.vim /${USER}/.vimrc
COPY ./scripts/container_setup.sh /bin/container_setup.sh

RUN container_setup.sh

COPY ./vim/coc-settings.json /${USER}/.vim/coc-settings.json
COPY ./zsh/zshrc /${USER}/.zshrc
COPY ./home/ripgreprc /${USER}/.ripgreprc

WORKDIR /root/workspace

ENTRYPOINT [ "gpg-agent", "--daemon" ]

CMD [ "zsh" ]

EXPOSE 8000
