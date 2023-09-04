#!/bin/env bash
export FZF_DEFAULT_OPTS='
  --color=pointer:#ebdbb2,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7,hl:#8ec07c,info:#928374,header:#fb4934
  --reverse
'
# export NAVI_PATH="$DOTFILES_PATH/doc/navi"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"


# export DENO_INSTALL="/home/rsbmk/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"
# export ZIM_HOME="$HOME/.zim"

paths=(
  "$HOME/bin"
  "$DOTFILES_PATH/bin"
  "/bin"
  "/usr/local/bin" # This contains Brew ZSH. If it's below `/bin` it won't be executed.
  # "/usr/local/opt/make/libexec/gnubin"
  "/usr/bin"
  "\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "$HOME/.deno/bin/deno"
)

PATH=$(
  IFS=":"
  echo "${paths[*]}"
)

export PATH
