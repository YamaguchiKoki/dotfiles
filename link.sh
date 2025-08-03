#!/bin/bash

DOTFILES_DIR="$HOME/.config"
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up dotfiles...${NC}"

# Define files and their destinations
files_and_paths=(
  "starship.toml:~/.config/starship.toml"
  ".gitconfig:~/.gitconfig"
)

# Zsh related files (respect ZDOTDIR)
zsh_files=(
  "zsh/.zshrc:${ZDOTDIR}/.zshrc"
  "zsh/.zshenv:${ZDOTDIR}/.zshenv"
  "zsh/.zprofile:${ZDOTDIR}/.zprofile"
)

# Function to create symlink
create_symlink() {
  local source_file=$(realpath "$1" 2>/dev/null || echo "$1")
  local destination_path=$(eval echo "$2")
  local backup_file="${destination_path}.bak"

  # Check if source file exists
  if [ ! -e "$source_file" ]; then
    echo -e "${YELLOW}⚠ Source file not found: $source_file${NC}"
    return 1
  fi

  # Create parent directory if it doesn't exist
  local parent_dir=$(dirname "$destination_path")
  if [ ! -d "$parent_dir" ]; then
    mkdir -p "$parent_dir"
    echo -e "${GREEN}✓ Created directory: $parent_dir${NC}"
  fi

  # Backup existing file if it exists and is not a symlink
  if [ -e "$destination_path" ] && [ ! -L "$destination_path" ]; then
    mv "$destination_path" "$backup_file"
    echo -e "${YELLOW}→ Backed up: $destination_path to $backup_file${NC}"
  fi

  # Remove existing symlink if it exists
  if [ -L "$destination_path" ]; then
    rm "$destination_path"
  fi

  # Create symlink
  ln -s "$source_file" "$destination_path"
  echo -e "${GREEN}✓ Linked: $source_file → $destination_path${NC}"
}

# Process general dotfiles
echo -e "\n${BLUE}Linking general dotfiles...${NC}"
for entry in "${files_and_paths[@]}"; do
  IFS=":" read -r source_file destination_path <<< "$entry"
  # Handle different source path patterns
  if [[ "$source_file" == .* ]]; then
    # Remove leading dot for hidden files
    source_path="${DOTFILES_DIR}/${source_file#.}"
  else
    # Use as-is for regular files
    source_path="${DOTFILES_DIR}/${source_file}"
  fi
  create_symlink "$source_path" "$destination_path"
done

# Process Zsh files
if [ -n "$ZDOTDIR" ]; then
  echo -e "\n${BLUE}Linking Zsh files (ZDOTDIR=$ZDOTDIR)...${NC}"
  for entry in "${zsh_files[@]}"; do
    IFS=":" read -r source_file destination_path <<< "$entry"
    source_path="${DOTFILES_DIR}/${source_file}"
    create_symlink "$source_path" "$destination_path"
  done
fi

echo -e "\n${GREEN}Setup complete!${NC}"
