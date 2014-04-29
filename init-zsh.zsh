!# /bin/zsh

if [ ! -f $HOME/.zpreztorc ]; then
  git clone --recursive git@github.com:zhangxiao/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  chsh -s /bin/zsh
else
  echo "already set - do nothing"
fi
