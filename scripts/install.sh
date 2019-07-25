#!/bin/bash
INSTALL_PATH=$(pwd)

echo "Preparando..."
if [ ! -d ~/tmp ]; then
	echo "Criando diretório ~/tmp"
	mkdir ~/tmp
else
	echo "Diretório ~/tmp já existe!"
fi

#################### Snap ####################
if [[ $(snap version) ]]; then
	echo "Snap já instalado!"
else
	sudo apt install snapd -y
fi

#################### Nodejs ####################
if [[ $(node -v) ]]; then
	echo "Node.js já instalado"
else
	sudo snap install node --classic --channel=12
fi

#################### Docker ####################
if [[ $(docker -v) ]]; then
	echo "Docker já instalado"
else
	# Install deps
	sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg2 \
		software-properties-common -y

	# Add GPG key
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

	# Add repo
	sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/debian \
		$(lsb_release -cs) \
		stable"

	sudo apt update

	# Install docker
	sudo apt-get install docker-ce docker-ce-cli containerd.io -y

	# Post install
	sudo groupadd docker
	sudo usermod -aG docker $USER
fi

#################### docker-compose ####################
if [[ $(docker-compose -v) ]]; then
	echo "docker-compose já instalado"
else
	curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
		-o /usr/local/bin/docker-compose

	sudo chmod +x /usr/local/bin/docker-compose
fi

#################### Java ####################

#################### Clojure + lein ####################
if [[ $(clj -h -n) ]]; then
	echo "Clojure já instalado"
else
	sudo apt install bash curl rlwrap -y
fi

#################### Neovim ####################
if [[ $(nvim -v) ]]; then
  echo "Neovim já instalado"
else
  git clone https://github.com/neovim/neovim.git ~/tmp/neovim
  cd ~/tmp/neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd $INSTALL_PATH
fi
