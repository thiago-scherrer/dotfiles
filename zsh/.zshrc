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
  python
  pyenv
  pylint
)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

source $ZSH/oh-my-zsh.sh
export PATH=$PATH:/usr/local/go/bin:/home/$USER/.local/bin:$HOME/go/bin/:$HOME/.tfenv/bin:/usr/games

export GPG_TTY=$(tty)
export VISUAL=/usr/bin/vim

EDITOR='vim'

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export FZF_DEFAULT_COMMAND='rg -l ""'

alias updateall="su -c 'pacman -Syu'"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export LS_COLORS=$LS_COLORS:'ow=37;42:'
