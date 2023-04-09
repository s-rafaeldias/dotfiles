stow:
	cd configs && ./setup.sh -f

install-ansible:
	python3 -m pip install --user ansible ansible-core

build:
	ansible-playbook local.yml --ask-become-pass

new: install-ansible build stow
