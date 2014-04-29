#! /bin/bash

if [ ! -d $HOME/.dotfiles ]; then
  git clone git@github.com:zhangxiao/dotfiles.git $HOME/.dotfiles
  $HOME/.dotfiles/setup
else
  echo "already set - do nothing"
fi
