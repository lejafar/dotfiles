#!/bin/bash
sudo apt-get update
sudo apt-get install -y git ruby tmux

# homesick dotfiles
sudo gem install homesick
homesick clone lejafar/dotfiles && homesick symlink dotfiles --force
homesick clone lejafar/dotvim && homesick symlink dotvim

# install most common python interpreter itself compile dependencies
sudo apt-get install aria2 build-essential curl git libbz2-dev libffi-dev liblzma-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev llvm make tk-dev wget xz-utils zlib1g-dev --yes
# install pyenv
curl https://pyenv.run | bash

export PATH="$HOME/.pyenv/bin:$PATH"
# download and compile python 3.9.4
pyenv install 3.9.4
# download and compile python 3.8.9
pyenv install 3.8.9
# download and compile python 3.7.10
pyenv install 3.7.10

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - --version 1.1.4
source $HOME/.poetry/env

# set up zsh & prezto
sudo apt-get install -y zsh
zsh
git clone --recursive https://github.com/lejafar/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
source ~/.zshrc

# vim 8
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y vim

# install Vundle plugins
vim +PluginInstall +qall

echo "######## All set! 🍌 ########"
echo "Activate zsh as default shell:"
echo "chsh -s /bin/zsh"
echo "#############################"
