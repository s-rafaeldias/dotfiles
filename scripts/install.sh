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
	apt install snapd -y
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
		software-properties-common -y

	# Add GPG key
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

	# Add repo
	add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/debian \
		$(lsb_release -cs) \
		stable"

	apt update

	# Install docker
	apt-get install docker-ce docker-ce-cli containerd.io -y

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

#################### Java ####################
if [[ $(java -version) ]]; then
	echo "Java já instalado"
else
	apt install openjdk-11-jdk -y
	echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment
	source /etc/environment
fi

#################### Clojure + lein ####################
if [[ $(clj -h -n) ]]; then
	echo "Clojure já instalado"
else
	apt install bash curl rlwrap -y
	curl -O https://download.clojure.org/install/linux-install-1.10.1.466.sh
	chmod +x linux-install-1.10.1.466.sh
	./linux-install-1.10.1.466.sh
	rm -rf linux-install-1.10.1.466.sh
fi

if [[ $(lein -v) ]]; then
	echo "Lein já instalado"
else
	curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /tmp/lein
	mv /tmp/lein /home/rafael/bin
	chmod a+x /home/rafael/bin/lein
fi
