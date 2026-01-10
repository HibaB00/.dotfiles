#!/usr/bin/env bash

# ============================================
# Health Check Script
# Verifies all dependencies are installed
# ============================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}==== $1 ====${NC}\n"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1 ${YELLOW}(not found)${NC}"
        return 1
    fi
}

check_directory() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "${RED}✗${NC} $2 ${YELLOW}(not found)${NC}"
        return 1
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "${RED}✗${NC} $2 ${YELLOW}(not found)${NC}"
        return 1
    fi
}

check_symlink() {
    if [ -L "$1" ]; then
        echo -e "${GREEN}✓${NC} $2 ${BLUE}→ $(readlink "$1")${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $2 ${YELLOW}(not symlinked)${NC}"
        return 1
    fi
}

# Core Tools
print_header "Core Tools"
check_command brew
check_command git
check_command stow
check_command nvim
check_command zsh

# CLI Utilities
print_header "CLI Utilities"
check_command rg
check_command fzf
check_command eza
check_command lazygit
check_command zellij

# Runtimes
print_header "Development Runtimes"
check_command node
check_command bun
check_command python3
check_command go

# macOS Tools
print_header "macOS Tools"
check_command sketchybar
check_command kitty

# Shell Configuration
print_header "Shell Configuration"
check_directory "$HOME/.oh-my-zsh" "Oh-My-Zsh"
check_directory "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" "Powerlevel10k"
check_symlink "$HOME/.zshrc" ".zshrc"
check_file "$HOME/.p10k.zsh" "P10K config"

# NVM
print_header "Node Version Manager"
check_directory "$HOME/.nvm" "NVM"

# Neovim
print_header "Neovim Configuration"
check_symlink "$HOME/.config/nvim" "nvim config"
check_directory "$HOME/.local/share/nvim/lazy" "Lazy.nvim plugins"

# Kitty
print_header "Kitty Terminal"
check_directory "$HOME/.config/kitty" "Kitty config"

# Other Configs
print_header "Other Configurations"
check_symlink "$HOME/.gitconfig" ".gitconfig"
check_directory "$HOME/.config/sketchybar" "Sketchybar config"
check_directory "$HOME/.config/zellij" "Zellij config"

# Fonts
print_header "Fonts"
if ls ~/Library/Fonts/*Nerd*.ttf 1> /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Nerd Fonts installed"
else
    echo -e "${RED}✗${NC} Nerd Fonts ${YELLOW}(not found)${NC}"
fi

# Sketchybar Helper
print_header "Sketchybar Helper"
check_file "$HOME/.config/sketchybar/helper/helper" "Compiled helper binary"

# Summary
print_header "Summary"
echo -e "${BLUE}Health check complete!${NC}"
echo -e "\nIf you see ${RED}✗${NC} or ${YELLOW}⚠${NC}, consider:"
echo "  - Running: ${BLUE}brew bundle${NC}"
echo "  - Running: ${BLUE}./scripts/bootstrap.sh${NC}"
echo "  - Running: ${BLUE}./install.sh${NC}"
