# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#     . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
#     . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# fi


# Created by `pipx` on 2023-04-08 22:48:22
export PATH="$PATH:/Users/rafael/.local/bin"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by `rbenv init` on Sat Oct  5 23:00:07 CEST 2024
eval "$(rbenv init - --no-rehash zsh)"
