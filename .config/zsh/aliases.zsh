export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -Fh'
alias la='ls -Fha'
alias ll='ls -Fhal'

alias cdr='cd $(git rev-parse --show-toplevel)'
alias pip='pip3'
alias python='python3'
alias resrc='. ~/.zshrc'

if command -v nvim &>/dev/null; then
    alias vi='nvim'
else
    alias vi='vim'
fi

alias s='screen'
alias sl='screen -ls'
alias sd='screen -d ${STY}'
alias sr='screen -r'
alias sR='screen -dr'
alias ss='screen -S'

alias t='tmux'
alias tl='tmux list-sessions'
alias td='tmux detach'
alias tt='tmux attach -t'
alias tR='tmux attach'
alias ts='tmux new -s'

alias icat='kitty +kitten icat --align=left'

if command -v batcat &>/dev/null; then
    # Bat is 'batcat' in Debian
    alias cat='batcat'
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
elif command -v bat &>/dev/null; then
    alias cat='bat'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

[ -d ${HOME}/.bash_aliases ] && source ${HOME}/.bash_aliases

function weather () {
    # Print the current weather.
    local url="v2d.wttr.in/${*}"
    if command -v curl &>/dev/null; then
        # Try with `curl` first
        curl -m 10 ${url} 2>/dev/null
    elif command -v wget &>/dev/null; then
        # Try with `wget` next
        wget -O - -q -T 600 ${url} 2>/dev/null
    else
        printf "%s\n" "[ERROR] weather: This command requires either 'curl' or 'wget' to be installed."
    fi
    if [ $? -ne 0 ]; then
        printf "%s\n" "[ERROR] weather: Could not connect to weather service. Try again later."
    fi
}

function fg-bg () {
    if [[ ${#BUFFER} -eq 0 ]]; then
        fg
    else
        zle push-input
    fi
}
zle -N fg-bg  # Create a bind to this function
bindkey "^Z" fg-bg

function dict-less () {
    command dict $@ | less
}
alias dict='dict-less'

function dump {
    date
    if [ -n "${STY+x}" ]; then
        print -P "Screen Session:\t${c_wht}${STY}${c_reset}"
    elif [ -n "${TMUX}" ]; then
        print -P "TMUX Session:\t${c_wht}$(tmux display-message -p '#S')${c_reset}"
    else;
        print -P "Session Info:\t${c_red}<No Session>${c_reset}"
    fi
    print -P "Logged in as:\t${c_wht}$(whoami)${c_reset}@${c_wht}$(hostname)${c_reset}"
}

# vim:foldmethod=marker:foldlevel=0:filetype=zsh
