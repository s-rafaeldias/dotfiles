#!/bin/bash

if [ $EUID != 0 ]; then
	echo "Favor rodar script com sudo"
	exit 1
fi

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
	apt install snapd
fi

#################### Nodejs ####################
if [[ $(node -v) ]]; then
	echo "Node.js já instalado"
else
	snap install node --classic --channel=12
fi

#################### Docker ####################
if [[ $(docker -v) ]]; then
	echo "Docker já instalado"
else
	# Install deps
	apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg2 \
		software-properties-common

	# Add GPG key
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

	# Add repo
	add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/debian \
		$(lsb_release -cs) \
		stable"

	apt update

	# Install docker
	apt-get install docker-ce docker-ce-cli containerd.io

	# Post install
	groupadd docker
	usermod -aG docker $USER
	newgrp docker 
fi

#################### docker-compose ####################
if [[ $(docker-compose -v) ]]; then
	echo "docker-compose já instalado"
else
	curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
		-o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose
fi
