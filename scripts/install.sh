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
if [ $(node -v) ]; then
	echo "Node.js já instalado"
else
	snap install node --classic --channel=12
fi
