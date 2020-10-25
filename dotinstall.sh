#!/bin/bash
sudo apt-get update
sudo apt-get install -y git ruby tmux

# homesick dotfiles
sudo gem install homesick
homesick clone lejafar/dotfiles && homesick symlink dotfiles --force
homesick clone lejafar/dotvim && homesick symlink dotvim

# set up zsh & prezto
sudo apt-get install -y zsh
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

# vim 8
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim
vim +PluginInstall +qall # install Vundle plugins

# prettier install
sudo apt-get install -y nodejs npm
pushd ~/.vim/bundle/vim-prettier
npm install
popd
