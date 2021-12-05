#!/usr/bin/env bash

cd vim 
git pull 
export VIMRUNTIMEDIR=/usr/share/vim/vim82

./configure \
    --enable-cscope \ 
    --enable-gui=gtk2 \ 
    --enable-luainterp=yes \ 
    --enable-multibyte \
    --enable-perlinterp=yes \ 
    --enable-python3interp=yes \ 
    --enable-rubyinterp=yes \
    --enable-terminal \
    --with-features=huge \
    --with-python3-config-dir=$(python3-config --configdir) 

make -j1 && sudo 'make install'

vim -c 'PlugUpgrade'
vim -c 'PlugUpdate'
vim -c 'CocUpdate'
