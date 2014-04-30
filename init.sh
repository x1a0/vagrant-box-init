#! /bin/bash

LANG="en_US.UTF-8"
LC_ALL=$LANG
export LANG LC_ALL

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo echo "* DIR set to $DIR"

_start() {
  echo -e "\e[36m>>>> $1 >>>>\e[0m"
}

_end() {
  echo -e "\e[31m<<<< Done <<<<\e[0m"
  echo ""
}

_start "Disable sudo auth (only works in bash now)"
OLD_EDITOR=$EDITOR
export EDITOR="/bin/bash $DIR/sudoedit-bridge.sh"
sudoedit /etc/sudoers
EDITOR=$OLD_EDITOR
_end

_start "Add ssh public key"
if [ ! -f $HOME/.ssh/authorized_keys ]; then
  mkdir -m 700 -p $HOME/.ssh
  cat $DIR/id_rsa.pub >> $HOME/.ssh/authorized_keys
  chmod 600 $HOME/.ssh/authorized_keys
else
  echo "authorized_keys exists - do nothing"
fi
_end

_start "Change APT sources"
sudo sed -i "s/us\./se./g" /etc/apt/sources.list
sudo update-grub
_end

_start "Install git, zsh, tmux, jq"
sudo apt-get install -y build-essential git zsh tmux jq
_end

_start "VIM configuration"
/bin/bash $DIR/init-vim.sh
_end

_start "Zsh Configuration"
/bin/zsh $DIR/init-zsh.zsh
_end

_start "Dotfiles"
/bin/bash $DIR/init-dotfiles.sh
_end

_start "Disable boot menu"
sudo sed -i "s/GRUB_TIMEOUT=2/GRUB_TIMEOUT=0/g" /etc/default/grub
sudo update-grub
_end
