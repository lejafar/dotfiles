#!/bin/bash
sudo apt-get update
sudo apt-get install -y git ruby tmux zsh

# homesick dotfiles
sudo gem install homesick
homesick clone lejafar/dotfiles && homesick symlink dotfiles --force
homesick clone lejafar/dotvim && homesick symlink dotvim

# vim 8
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim
vim +PluginInstall +qall # install Vundle plugins

# set up zsh & prezto
zsh
git clone --recursive https://github.com/lejafar/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
source ~/.zshrc
chsh -s /bin/zsh

# pyenv
curl https://pyenv.run | bash

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
