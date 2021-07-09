export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME="sonicradish"

export UPDATE_ZSH_DAYS=1

DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
  git
  ubuntu
  nmap
  golang
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/go/bin:/home/$USER/.local/bin:$HOME/go/bin/:$HOME/.tfenv/bin
export GPG_TTY=$(tty)
export VISUAL=/usr/bin/vim

source $HOME/.cargo/env

EDITOR='vim'

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export FZF_DEFAULT_COMMAND='rg -l ""'

alias updateall="sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt clean all"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
