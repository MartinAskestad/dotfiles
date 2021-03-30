#!/usr/bin/env bash
# This file runs once at login

# Add all local binary path to the system path
# set PATH so it includes users private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes users private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

PATH="./node_modules/.bin:$PATH"

# Default programs to run
export EDITORT"vim"

# Add colors to less and man commands
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

# If bash id the login shell, then source .bashrs if exists
echo "${0}" | grep "bash$" >/dev/null \
  && [ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
