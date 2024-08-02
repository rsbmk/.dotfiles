#!/bin/env bash
export FZF_DEFAULT_OPTS='
  --color=pointer:#ebdbb2,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7,hl:#8ec07c,info:#928374,header:#fb4934
  --reverse
'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

paths=(
  "$HOME/bin"
  "$DOTFILES_PATH/bin"
  "/bin"
  "/usr/local/bin" # This contains Brew ZSH. If it's below `/bin` it won't be executed.
  "/usr/bin"
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "/usr/bin:/bin:/usr/sbin:/sbin"
  "/usr/local/bin:/usr/local/sbin:$PATH"
  "$HOME/.cargo/bin"
)

PATH=$(
  IFS=":"
  echo "${paths[*]}"
)

export PATH
