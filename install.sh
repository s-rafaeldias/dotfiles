#!/bin/bash
INSTALL_PATH=$(pwd)
. _helpers.sh

echo "Preparando..."
if [ ! -d ~/tmp ]; then
	echo_info "Criando diretório ~/tmp"
	mkdir ~/tmp
else
	echo_info "Diretório ~/tmp já existe!"
fi

#################### Git ####################
if type -p git > /dev/null; then
	echo_done "Git já instalado!"
else
	sudo apt-get install git -y
fi

#################### Nodejs ####################

#################### Snap ####################
if type -p snap > /dev/null; then
	echo_done "Snap já instalado!"
else
	sudo apt install snapd -y
fi

#################### Nodejs ####################
if type -p node > /dev/null; then
	echo_done "Node.js já instalado"
else
	sudo snap install node --classic --channel=12
fi

# #################### Docker ####################
# if [[ $(docker -v) ]]; then
	# echo "Docker já instalado"
# else
	# # Install deps
	# sudo apt-get install \
		# apt-transport-https \
		# ca-certificates \
		# curl \
		# gnupg2 \
		# software-properties-common -y

	# # Add GPG key
	# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

	# # Add repo
	# sudo add-apt-repository \
		# "deb [arch=amd64] https://download.docker.com/linux/debian \
		# $(lsb_release -cs) \
		# stable"

	# sudo apt update

	# # Install docker
	# sudo apt-get install docker-ce docker-ce-cli containerd.io -y

	# # Post install
	# sudo groupadd docker
	# sudo usermod -aG docker $USER
# fi

# #################### docker-compose ####################
# if [[ $(docker-compose -v) ]]; then
	# echo "docker-compose já instalado"
# else
	# curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
		# -o /usr/local/bin/docker-compose

	# sudo chmod +x /usr/local/bin/docker-compose
# fi

# #################### Java ####################
if type -p java > /dev/null; then
	echo_done "Java já instalado"
else
	sudo apt install openjdk-11-jdk -y
	sudo echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment
	sudo source /etc/environment
fi

# #################### Clojure + lein ####################
# if [[ $(clj -h -n) ]]; then
	# echo "Clojure já instalado"
# else
	# sudo apt install bash curl rlwrap -y
	# curl -O https://download.clojure.org/install/linux-install-1.10.1.466.sh
	# sudo chmod +x linux-install-1.10.1.466.sh
	# ./linux-install-1.10.1.466.sh
	# rm -rf linux-install-1.10.1.466.sh
# fi

# if [[ $(lein -v) ]]; then
	# echo "Lein já instalado"
# else
	# curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /tmp/lein
	# mv /tmp/lein /home/rafael/bin
	# sudo chmod a+x /home/rafael/bin/lein
# fi

# #################### Ruby ####################
# if [[ $(ruby -v) ]]; then
	# echo "Ruby já instalado"
# else
	# # sudo snap install ruby --classic
	# sudo apt install ruby -v
# fi

# #################### Neovim ####################
# if [[ $(nvim -v) ]]; then
	# echo "Neovim já instalado"
# else
	# sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
	# git clone https://github.com/neovim/neovim.git ~/tmp/neovim
	# cd ~/tmp/neovim
	# git checkout stable
	# make CMAKE_BUILD_TYPE=Release
	# sudo make install
	# cd $INSTALL_PATH
# fi
