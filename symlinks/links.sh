#!/bin/env bash
rm -rf ~/.ssh ~/.config/Code/User ~/.gitignore_global ~/.gitconfig ~/.config/starship.toml ~/.zshenv ~/.zshrc ~/.zimrc ~/.bashrc
ln -s "$HOME/.dotfiles/terminal/bash/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zimrc" "$HOME/.zimrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zshenv" "$HOME/.zshenv"
ln -s "$HOME/.dotfiles/terminal/zsh/starship.toml" "$HOME/.config/starship.toml"
ln -s "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/vs-code/User" "$HOME/.config/Code/User"
ln -s "$HOME/.dotfiles/.ssh" "$HOME/.ssh"