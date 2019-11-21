# Created by newuser for 5.0.2

# GENERAL OPTIONS
setopt IGNOREEOF

zmodload zsh/regex

# CHANGE DIRECTORY OPTIONS
setopt auto_pushd
setopt pushd_ignore_dups
function chpwd() { ls }

# LOAD MODULES
autoload -Uz colors
colors

autoload -Uz compinit
compinit

autoload -Uz history-search-end

# HISTORY OPTIONS
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# VIM KEYMAPS
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

bindkey -M vicmd 'qw' quote-line

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

stty erase ^H
bindkey "^[[3~" delete-char

#
# GLOBAL ZLE SETTING
#
typeset -g -A G_ZLE_LINEINIT_FUNCTIONS
typeset -g -A G_ZLE_ACCEPTLINE_FUNCTIONS
typeset -g -A G_ZLE_KEYMAPSELECT_FUNCTIONS

zle -N zle-line-init
zle -N accept-line
zle -N zle-keymap-select

function zle-line-init () {
    for key in ${(k)G_ZLE_LINEINIT_FUNCTIONS}; do
        ${=G_ZLE_LINEINIT_FUNCTIONS[${key}]}
    done
    zle reset-prompt
}

function accept-line () {
    for key in ${(k)G_ZLE_ACCEPTLINE_FUNCTIONS}; do
        ${=G_ZLE_ACCEPTLINE_FUNCTIONS[${key}]}
    done
    zle .accept-line
}

function zle-keymap-select () {
    for key in ${(k)G_ZLE_KEYMAPSELECT_FUNCTIONS}; do
        ${=G_ZLE_KEYMAPSELECT_FUNCTIONS[${key}]}
    done
    zle reset-prompt
}

# PROMPT
G_ZLE_LINEINIT_FUNCTIONS[prompt]="sy-prompt-init"
G_ZLE_KEYMAPSELECT_FUNCTIONS[prompt]="sy-prompt-init"

function sy-prompt-init {
    case $KEYMAP in
        vicmd)
            PROMPT="%{$fg[cyan]%}[N]%{$reset_color%}-%{$fg[green]%}[%n@%m]-%{$reset_color%}%# "
        ;;
        main|viins)
            PROMPT="%{$fg[red]%}[I]%{$reset_color%}-%{$fg[green]%}[%n@%m]-%{$reset_color%}%# "
        ;;
    esac
}

# ALIASES
alias ll="ls -l --color=auto"
alias h="fc -lt '%F %T' 1"
alias cp="cp -i"
alias rm="rm -i"
alias mkdir="mkdir -p"
