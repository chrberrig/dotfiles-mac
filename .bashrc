#!/bin/bash
#    _              _
#   | |            | |
#   | |            | |
#   | |_  ___  ___ | |_  _ __  __   
#   |   \/   |/ __||   \| / _|/ _|
#   | O || O |\__ \| | ||  / | |_
#  O|___/\___\/___/|_|_||_|   \__|
# 
# --- This sets the glabal bash path ---
echo "Using .bashrc"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"	# From HomeBrew install.
export PATH="$PATH:/Library/TeX/texbin"			# Finding MACTeX compiler etc.
export PATH="$PATH:$(du "$HOME/.scripts" | cut -f2 | tr '\n' ':' | sed 's/:*$//')" # Adds .scripts and all its subfolders to path.
# # export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin"
# 
# --- This formats the promt, to show current check out'd git branch and changes promt format to linux standard format. ---
# - Old Format: - 
# PS1="\h:\W \u\$"
# - New Format: -
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="[\u@\h \W]\$(git_branch)\$ "

# --- This is for defining other environment variables ---
# export BROWSER="usr/bin/firefox"
export EDITOR="vim"
export LATEX="$HOME/Documents/LaTeX"
export BIB="$LATEX/bib.bib"

# --- This is for making new/modified commands and folder shortcuts, sourced from .config folder ---
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
