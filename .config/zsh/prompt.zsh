autoload colors && colors

function insert-mode () {}
function normal-mode () { echo "-- NORMAL --" }
function virtual-env () {
    if (( ${+VIRTUAL_ENV} )); then
        local venv_str=$(echo ${VIRTUAL_ENV} | awk -F'/' '{print $NF}')
        echo "${c_grn}${venv_str}${c_rst} "
    fi
}
function screen-sty () {
    if (( ${+STY} )); then
        local sty_str=$(echo ${STY} | awk -F'.' '{print $NF}')
        echo "${c_wht}${sty_str}${c_rst} "
    fi
}
function git-status () {
}
function git-branch () {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ $(git status --porcelain) == "" ]]; then
            local prefix="${c_grn}✓"
        else
            local prefix="${c_red}✗"
        fi
        echo "(${prefix} ${c_gry}$(git rev-parse --abbrev-ref HEAD)${c_rst})"
    fi
}

RPROMPT="$(screen-sty)[${c_ylw}%D{%H:%M:%S}${c_rst}]"

local NEWLINE=$'\n'
precmd () {
    print -rP "${NEWLINE}${c_blu}%~ ${c_rst}$(git-branch)"
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
    PS1="${VIMODE}$(virtual-env)%(?..${c_red})%# ${c_rst}"
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
#
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

