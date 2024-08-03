#!/bin/bash

# Define variables
REPO_URL="https://github.com/rsbmk/.dotfiles"
INIT_SCRIPT="terminal/init.sh"
CLONE_DIR="$HOME/.dotfiles"
SCRIPT_URL="https://raw.githubusercontent.com/rsbmk/.dotfiles/master/install_dotfiles.sh"

# Check if wget or curl is installed
if ! command -v curl &>/dev/null; then
  apt install curl -y
fi

# Check if git is installed
if ! command -v git &>/dev/null; then
  apt install git -y
fi

# Generate locale if needed
if ! locale -a | grep -q "en_US.utf8"; then
  echo "Generating en_US.UTF-8 locale..."
  if command -v locale-gen &>/dev/null; then
    sudo locale-gen en_US.UTF-8
  elif [ -f /etc/locale.gen ]; then
    sudo sed -i 's/^# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
    sudo locale-gen
  elif [ -f /etc/default/locale ]; then
    echo "LANG=en_US.UTF-8" | sudo tee -a /etc/default/locale
    sudo dpkg-reconfigure --frontend=noninteractive locales
  else
    echo "Cannot generate locale. Please ensure the system has locale support."
    exit 1
  fi
  sudo update-locale LANG=en_US.UTF-8
else
  echo "Locale en_US.UTF-8 already exists."
fi

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
