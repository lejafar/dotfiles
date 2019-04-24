#!/bin/bash
sudo apt-get install -y ruby
sudo gem install homesick
homesick clone lejafar/dotfiles && homesick symlink dotfiles --force
homesick clone lejafar/dotvim && homesick symlink dotvim

# install YouCompleteMe
sudo apt-get install -y python-dev
~/.vim/bundle/YouCompleteMe/install.py --clang-completer

source ~/.bashrc
sudo apt-get install -y exuberant-ctags silversearcher-ag software-properties-common

# tmux
sudo apt-get install tmux

# vim 8
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim
