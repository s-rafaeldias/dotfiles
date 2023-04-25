stow:
	cd configs && ./setup.sh -f

install-ansible:
	python3 -m pip install --user ansible ansible-corey

build:
	ansible-playbook local.yml

build-debug:
	ansible-playbook local.yml --check

new: install-ansible build stow


# vim: ft=make
