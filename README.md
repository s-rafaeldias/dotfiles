# Nix-dotfiles (WIP)

## Why?
I need some way to replicate my dev environment on multiple machines.
Before I was using `stow` and a [git repo](https://github.com/s-rafaeldias/dotfiles) to keep
all synced, but it only works for my dotfiles.

I needed a way to also keep in sync all the tools and apps (like nightly neovim) I use in a way
that is easy to setup on a new machine.

[Nix](https://nixos.org/) and [Home-manager](https://nix-community.github.io/home-manager/) seems to be a good way to solve this, besides it
does sound a good way to setup a dev environment too (still learning to
create a good setup/understanding on this).

[Flakes](https://nixos.wiki/wiki/Flakes) is probably the best way to
achieve what I want, since I can create different "profiles" for my work
and personal machines.


## TODO
- [ ] Setup flakes
- [ ] Refactor `home.nix`
- [ ] Migrate all dotfiles from the [old repo](https://github.com/s-rafaeldias/dotfiles)
