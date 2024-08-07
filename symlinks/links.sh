#!/bin/bash
rm -rf ~/.config/alacritty/alacritty.yml ~/.config/Code/User ~/.gitignore_global ~/.gitconfig ~/.config/starship.toml ~/.zshenv ~/.zshrc ~/.zimrc ~/.bashrc ~/.gitattributes ~/.ssh/config
# ~/.ssh
ln -s "$HOME/.dotfiles/terminal/bash/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zimrc" "$HOME/.zimrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/terminal/zsh/.zshenv" "$HOME/.zshenv"
# ln -s "$HOME/.dotfiles/terminal/zsh/starship.toml" "$HOME/.config/starship.toml"
ln -s "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
# ln -s "$HOME/.dotfiles/terminal/emulators/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
# ln -s "$HOME/.dotfiles/terminal/emulators/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/.dotfiles/git/.gitattributes" "$HOME/.gitattributes"
ln -s "$HOME/.dotfiles/terminal/config" "$HOME/.ssh/config"
