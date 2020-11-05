export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -Fh'
alias la='ls -Fha'
alias ll='ls -Fhal'

alias cdr='cd $(git rev-parse --show-toplevel)'
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

[ -d ${HOME}/.bash_aliases ] && source ${HOME}/.bash_aliases

function weather () {
    # Print the current weather.
    local url="wttr.in/${*}"
    if command -v curl &>/dev/null; then
        # Try with `curl` first
        curl -m 10 ${url} 2>/dev/null \
            || printf "%s\n" "[ERROR] weather: Could not connect to weather service. Try again later."
    elif command -v wget &>/dev/null; then
        # Try with `wget` next
        wget -O - -q -T 600 ${url} 2>/dev/null \
            || printf "%s\n" "[ERROR] weather: Could not connect to weather service. Try again later."
    else
        printf "%s\n" "[ERROR] weather: This command requires either 'curl' or 'wget' to be installed."
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

function dict-less () {
    command dict $@ | less
}
alias dict='dict-less'

function dump {
    date
    if [ -n "${STY+x}" ]; then
        print -P "Session ID:\t${c_wht}${STY}${c_rst}"
    else;
        print -P "Session ID:\t${c_red}<No Session>${c_rst}"
    fi
    print -P "Logged in as:\t${c_wht}$(whoami)${c_rst}@${c_wht}$(hostname)${c_rst}"
}

# vim:foldmethod=marker:foldlevel=0:filetype=zsh
