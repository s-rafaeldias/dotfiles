# Exports =======================================
set -Ux LC_ALL en_US.UTF-8
set -Ux EDITOR nvim
set -Ux TERM xterm-256color
set -Ux FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"

fish_add_path $HOME/bin
fish_add_path $HOME/lib
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/workspace/scripts
# Python
fish_add_path $HOME/miniconda3/bin
fish_add_path $HOME/.poetry/bin
# LLVM
fish_add_path /usr/local/opt/llvm/bin
set -gx LDFLAGS "-L/usr/local/opt/llvm/lib"
set -gx CPPFLAGS "-I/usr/local/opt/llvm/include"
# Ruby
set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
status --is-interactive; and source (rbenv init -|psub)
# Lua
fish_add_path /usr/local/opt/lua@5.3/bin
fish_add_path $HOME/.luarocks/bin
set -gx LDFLAGS "-L/usr/local/opt/lua@5.3/lib"
set -gx CPPFLAGS "-I/usr/local/opt/lua@5.3/include"
# Go
fish_add_path /usr/local/go/bin
set -Ux GOPATH $HOME/workspace/go
fish_add_path $GOPATH/bin
# Yarn
fish_add_path $HOME/.yarn/bin
fish_add_path $HOME/.config/yarn/global/node_modules/.bin
# Android
set -Ux ANDROID_SDK /Users/rafael/Library/Android/sdk
# Perl
# eval "(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
# Alias =======================================
abbr -a bu brew upgrade
abbr -a vi nvim
abbr -a vim nvim

# Some `ls` shortcuts
abbr -a l ls -alF
abbr -a la ls -A
abbr -a ll ls -CF

# Tmuxinator
abbr -a txn tmuxinator new
abbr -a txs tmuxinator start
abbr -a txl tmuxinator list
abbr -a txo tmuxinator open


# Turn VPN on and off
function vpn_off
    command launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
end
function vpn_on
    command launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
end

function inflate
    command ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"
end

function ports
    command lsof -P -i TCP -s TCP:LISTEN
end

function source_config
    source $HOME/.config/fish/config.fish
end

function md -d "mkdir -p"
    command mkdir -p $argv
end

# Prompt =======================================
# Setting up prompt
function fish_prompt
    set_color yellow
    printf '%s' $USER
    set_color normal
    printf ' at '

    set_color magenta
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    # pwd
    set_color green
    set -g fish_prompt_pwd_dir_length 0
    printf '%s' (prompt_pwd)
    set_color normal

    # git configs
    echo
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showupstream informative
    # set_color green
    printf '%s ' (fish_git_prompt)

    # Line 2
    set_color normal
    printf '↪ '
end

function fish_right_prompt
    set_color magenta
    printf 'k8:'
    echo -n (kubectl config current-context)
    set_color normal
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/rafael/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
