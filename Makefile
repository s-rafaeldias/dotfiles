stow:
	stow configs -t "${HOME}"

install-ansible:
	python3 -m pip install --user ansible ansible-core

build:
	ansible-playbook local.yml

build-debug:
	ansible-playbook local.yml --check

new: install-ansible build stow
