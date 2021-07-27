autoload colors && colors

function insert-mode () {}
function normal-mode () { echo "-- NORMAL --" }
function virtual-env () {
    if (( ${+VIRTUAL_ENV} )); then
        local venv_str=$(echo ${VIRTUAL_ENV} | awk -F'/' '{print $NF}')
        echo "${c_grn}${venv_str}${c_reset} "
    fi
}
function screen-sty () {
    if (( ${+STY} )); then
        local sty_str=$(echo ${STY} | awk -F'.' '{print $NF}')
        echo "${c_wht}${sty_str}${c_reset} "
    fi
}
function get-hostname () {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "${c_ylw}$(hostname -i 2>/dev/null)${c_reset} "
    else
        echo "${c_ylw}Localhost${c_reset} "
    fi
}
function git-branch () {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ $(git status --porcelain) == "" ]]; then
            local prefix="${c_grn}✓"
        else
            local prefix="${c_red}✗"
        fi
        echo "(${prefix} ${c_gry}$(git rev-parse --abbrev-ref HEAD)${c_reset})"
    fi
}

RPROMPT="$(screen-sty)$(get-hostname)[${c_gry}%D{%H:%M}${c_reset}]"

local NEWLINE=$'\n'
precmd () {
    # Set terminal title to truncated working directory
    print -Pn "\e]0;%(5~|%-1~/…/%3~|%4~)\a"
    # Print directory info above the prompt
    print -Pr "${NEWLINE}${c_blu}%~ ${c_reset}$(git-branch)"
    set-prompt
}
function set-prompt () {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="$(normal-mode)" ;;
      (main|viins) VI_MODE="$(insert-mode)" ;;
      (*)          VI_MODE="$(insert-mode)" ;;
    esac
    terminfo_down_sc=${terminfo[cud1]}${terminfo[cuu1]}${terminfo[sc]}${terminfo[cud1]}
    VIMODE="%{${terminfo_down_sc}${VI_MODE}${terminfo[rc]}%}"
    PS1="${VIMODE}$(virtual-env)%(?..${c_red})%# ${c_reset}"
}

function zle-line-init zle-keymap-select {
    set-prompt
    zle reset-prompt
}
preexec () { print -rn -- ${terminfo[el]}; }

# Enable vi mode
bindkey -v
zle -N zle-line-init
zle -N zle-keymap-select

# Make keys work
bindkey "^[[1~" beginning-of-line   # Home
bindkey "^[[4~" end-of-line         # End
bindkey "^?" backward-delete-char   # Backspace
bindkey "^U" backward-kill-line

# Enable partial history search
autoload -U history-search-end  # Have the cursor at the end of the line
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

