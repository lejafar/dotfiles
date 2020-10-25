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

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - --version 1.1.4
source $HOME/.poetry/env

# vim 8
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim
vim -c 'PluginInstall' -c 'qa!' # install Vundle plugins

# prettier install
sudo apt-get install -y nodejs npm
pushd ~/.vim/bundle/vim-prettier
npm install
popd

# install pyenv
curl https://pyenv.run | bash
