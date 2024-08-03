#!/bin/bash

# Define variables
REPO_URL="https://github.com/rsbmk/.dotfiles"
INIT_SCRIPT="terminal/init.sh"
CLONE_DIR="$HOME/.dotfiles"

# Clone the repository
if [ -d "$CLONE_DIR" ]; then
  echo "The directory $CLONE_DIR already exists. Pulling latest changes..."
  cd "$CLONE_DIR" && git pull
else
  echo "Cloning the repository..."
  git clone "$REPO_URL" "$CLONE_DIR"
fi

# Execute the init script
if [ -f "$CLONE_DIR/$INIT_SCRIPT" ]; then
  echo "Executing the init script..."
  bash "$CLONE_DIR/$INIT_SCRIPT"
else
  echo "The init script $CLONE_DIR/$INIT_SCRIPT does not exist."
  exit 1
fi

echo "Dotfiles installation complete."
