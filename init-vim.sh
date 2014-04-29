#! /bin/bash

if [ ! -f $HOME/.vimrc ]; then
  git clone --recursive git@github.com:zhangxiao/dotvim.git $HOME/.vim
  ln -sf $HOME/.vim/vimrc $HOME/.vimrc
  vim +PluginInstall +qall
else
  echo "already set - do nothing"
fi
