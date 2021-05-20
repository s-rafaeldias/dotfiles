# Exports =======================================
set -Ux LC_ALL en_US.UTF-8
set -Ux EDITOR nvim
set -Ux TERM xterm-256color
set -Ux FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"

set -Ux PATH $PATH $HOME/bin
set -Ux PATH $PATH $HOME/lib
set -Ux PATH $PATH $HOME/.local/bin
set -Ux PATH $PATH $HOME/.cargo/bin
set -Ux PATH $PATH $HOME/workspace/scripts
# Python
set -Ux PATH $PATH $HOME/miniconda3/bin
set -Ux PATH $PATH $HOME/.poetry/bin
# Ruby
set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
status --is-interactive; and source (rbenv init -|psub)
# Lua
set -Ux PATH $PATH $HOME/.luarocks/bin
# Go
set -Ux PATH $PATH /usr/local/go/bin
set -Ux GOPATH $HOME/workspace/go
set -Ux PATH $PATH $GOPATH/bin
# Yarn
set -Ux PATH $PATH $HOME/.yarn/bin
set -Ux PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

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

# Setting up prompt
# function fish_prompt
    # set -l last_status $status
    # if set -q CONDA_LEFT_PROMPT
        # __conda_add_prompt
    # end

    # return_last_status $last_status
    # __fish_prompt_orig
# end



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/rafael/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
