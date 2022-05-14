# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/submodules/powerlevel10k/powerlevel10k.zsh-theme

# Enable vi mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
    case $(uname -s) in 
        # TODO: test other options
        *Darwin*)   COPY_CMD="pbcopy -i" ;;
        *Linux*)    COPY_CMD="xclip" ;;
        *)          COPY_CMD="xclip" ;;
    esac
    zle vi-yank
    eval "echo '${CUTBUFFER}' | ${COPY_CMD}"
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Make keys work
bindkey "^[[1~" beginning-of-line   # Home
bindkey "^[[4~" end-of-line         # End
bindkey "^?" backward-delete-char   # Backspace
bindkey "^U" backward-kill-line     # Ctrl+U

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
