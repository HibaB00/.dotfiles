#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
fi

cd "$DOTFILES_DIR"

print_info "Updating dotfiles..."

# Check for uncommitted changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    print_warning "You have uncommitted changes!"
    git status --short
    echo -n "Stash changes and continue? (y/N): "
    read -r confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        git stash
        STASHED=1
    else
        exit 1
    fi
fi

# Pull latest changes
print_info "Pulling latest changes..."
git pull origin main

print_success "Dotfiles updated!"

# Unstash if we stashed
if [ -n "$STASHED" ]; then
    print_info "Restoring stashed changes..."
    git stash pop
fi

# Ask to restow
echo -n "Restow configurations? (Y/n): "
read -r restow

if [[ ! $restow =~ ^[Nn]$ ]]; then
    print_info "Restowing configurations..."
    "$DOTFILES_DIR/install.sh"
fi

print_success "Update complete!"
echo -e "\n${YELLOW}Don't forget to:${NC}"
echo "  - Restart terminal or: ${BLUE}exec zsh${NC}"
echo "  - Update Neovim plugins: ${BLUE}nvim +Lazy sync${NC}"
echo "  - Update Brew: ${BLUE}brew update && brew upgrade${NC}"
