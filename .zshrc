#!/bin/zsh
#              _
#             | |
#             | |
#    ____ ___ | |_  _ __  __   
#   /_  // __||   \| / _|/ _|
#    / /_\__ \| | ||  / | |_
#  O/___//___/|_|_||_|   \__|
# 
# === Environment Variables === 

# --- This sets the glabal bash path ---
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"      # From HomeBrew install.
export PATH="$PATH:/Library/TeX/texbin"                 # Finding MACTeX compiler etc.
export PATH="$PATH:$(du "$HOME/.scripts" | cut -f2 | tr '\n' ':' | sed 's/:*$//')" # Adds .scripts and all its subfolders to path.
# # export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin"

# --- History file and options ---
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history # ZDOTDIR is defined in ~/.zshenv
SAVEHIST=5000
HISTSIZE=2000
setopt EXTENDED_HISTORY
setopt HIST_VERIFY

setopt CORRECT

# === Completion ===
# autoload -Uz compinit && compinit
# Basic auto/tab complete: <-- from LukeSmith
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# === Prompt ===
# --- This formats the promt, to show current check out'd git branch and changes promt format to linux standard format. ---
# --- git integration ---
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{blue}(%b)%r %f'
zstyle ':vcs_info:*' enable git

# --- colours ---
# autoload -U colors && colors
# PS1="[%{fg[green]%}%n@%M %{fg[orange]%}%~] %{fg[magenta]%}%#%{$reset_color%}% "
PS1="[%F{green}%n%f@%m %F{202}%~%f] %F{magenta}%#%f \$vcs_info_msg_0_"


# --- This is for defining other environment variables ---
# export BROWSER="usr/bin/firefox"
export EDITOR="vim"
export LATEX="$HOME/Documents/LaTeX"
export BIB="$LATEX/bib.bib"

# --- This is for making new/modified commands and folder shortcuts, sourced from .config folder ---
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
