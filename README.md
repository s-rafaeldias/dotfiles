# .dotfiles
> ~/ sweet ~/


This is mine dotfiles setup.

## Setting up
```bash
ansible-playbook playbook.yml --ask-become-pass
# or
ansible-pull -U https://github.com/s-rafaeldias/dotfiles --ask-become-pass
```

### Dotfiles only
`stow` is used to symlink everything in place.
To setup everything in place:
```bash
make stow
```

## nvim setup
This is where most of my changes happen. I'm ALWAYS experiment with my nvim setup.

## TODO
- [ ] Create a ansible playbook to install things (at least for MacOS)
- [ ] Review nvim setup
- [ ] Document this better xD

# Acknowledgements
Some repos that I used as references for building my dotfiles:
- [tjdevries/config_manager](https://github.com/tjdevries/config_manager)
- [ThePrimeagen/init.lua](https://github.com/ThePrimeagen/init.lua)
