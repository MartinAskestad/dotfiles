#!/usr/bin/env bash
# This file runs everytime you open a new terminal window

# Enable VI-mode
set -o vi

# Limit the number of lines and entries in the history
export HISTFILESIZE=500
export HISTSIZE=500

# Add a timestamp to each command
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S:   "

# Duplicate lines and lines starting with space are not put in history
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite
shopt -s histappend

# Ensure $LINES and $COLUMNs always get updated
shopt -s checkwinsize

# Enable bash completion
[[ $PS! && -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

# Load aliases if they exist
[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"

# detemine git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set prompt
PS1='\[[01;32m\]\u@\h\[[00m\]:\[[01;34m\]\w\[[00m\] \[[01;33m\]$(parse_git_branch)\[[00m\]\$ '

# Enable a better reverse search experience
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."

# WSL2 specific
if grep -q "microsoft" /proc/version &>/dev/null; then
  export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"

   # Allows your gpg passphrase prompt to spawn
   export GPG_TTY=$(tty)
fi

# WSL! specific
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
  if [ "$(umask)" = "0000" ]; then
    umask 0022
  fi

  export DISPLAY=:0
fi
