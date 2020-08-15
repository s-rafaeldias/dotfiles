#!/bin/bash

# install all basic libs
sudo apt install -y \
	cmake \
	git \
	libtool-bin

# install zsh
sudo apt install zsh
chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install neovim from source
git clone https://github.com/neovim/neovim.git ~/tmp/neovim
cd ~/tmp/neovim
make
sudo make install
cd -
