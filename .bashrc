# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return ;;
esac
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

# don't put duplicate lines or lines starting with space in history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# set the history length
HISTSIZE=100
HISTFILESIZE=200

export PATH=./node_modules/.bin:$PATH

# Set VI-mode
set -o vi

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ls='ls -lh --group-directories-first'
