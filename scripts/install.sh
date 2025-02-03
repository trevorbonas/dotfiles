#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.." && pwd)"
if [ $? -eq 0 ]; then
  echo -e "${GREEN}dotfiles directory found${NC}"
else
  echo -e "${RED}dotfiles directory not found${NC}"
  exit 1
fi

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No colour

# Neovim
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Installed Neovim configuration${NC}"
else
  echo -e "${RED}Failed to install Neovim configuration${NC}"
  exit 1
fi

# Tmux
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Installed Tmux configuration${NC}"
else
  echo -e "${RED}Failed to install Tmux configuration${NC}"
  exit 1
fi

# SSH
mkdir -p ~/.ssh
ln -sf "$DOTFILES_DIR/ssh/config" ~/.ssh/config
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Installed SSH configuration${NC}"
else
  echo -e "${RED}Failed to install SSH configuration${NC}"
  exit 1
fi

echo -e "${GREEN}All configurations successfully installed${NC}"
