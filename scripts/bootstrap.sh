#!/usr/bin/env bash

set -e

# ============================================
# Bootstrap Script
# Installs all prerequisites and dependencies
# ============================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}==== $1 ====${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

# ============================================
# Homebrew
# ============================================
install_homebrew() {
    if command -v brew &> /dev/null; then
        print_success "Homebrew already installed"
        return
    fi
    
    print_header "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed"
}

# ============================================
# Oh-My-Zsh
# ============================================
install_oh_my_zsh() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh-My-Zsh already installed"
        return
    fi
    
    print_header "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh-My-Zsh installed"
}

# ============================================
# Powerlevel10k
# ============================================
install_powerlevel10k() {
    local P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    
    if [ -d "$P10K_DIR" ]; then
        print_success "Powerlevel10k already installed"
        return
    fi
    
    print_header "Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    print_success "Powerlevel10k installed"
}

# ============================================
# NVM
# ============================================
install_nvm() {
    if [ -d "$HOME/.nvm" ]; then
        print_success "NVM already installed"
        return
    fi
    
    print_header "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install LTS Node
    nvm install --lts
    print_success "NVM installed with Node LTS"
}

# ============================================
# Bun
# ============================================
install_bun() {
    if command -v bun &> /dev/null; then
        print_success "Bun already installed"
        return
    fi
    
    print_header "Installing Bun"
    curl -fsSL https://bun.sh/install | bash
    print_success "Bun installed"
}

# ============================================
# Brew Dependencies
# ============================================
install_brew_deps() {
    print_header "Installing Homebrew Dependencies"
    
    if [ -f "$HOME/.dotfiles/Brewfile" ]; then
        cd "$HOME/.dotfiles"
        brew bundle
        print_success "All Homebrew dependencies installed"
    else
        echo -e "${YELLOW}No Brewfile found, skipping${NC}"
    fi
}

# ============================================
# Sketchybar Helper
# ============================================
build_sketchybar_helper() {
    local HELPER_DIR="$HOME/.dotfiles/sketchybar/.config/sketchybar/helper"
    
    if [ ! -d "$HELPER_DIR" ]; then
        return
    fi
    
    print_header "Building Sketchybar Helper"
    cd "$HELPER_DIR"
    make
    print_success "Sketchybar helper built"
}

# ============================================
# Main
# ============================================
main() {
    print_header "Bootstrap Dotfiles"
    
    echo -e "${YELLOW}This will install:${NC}"
    echo "  - Homebrew"
    echo "  - Oh-My-Zsh"
    echo "  - Powerlevel10k"
    echo "  - NVM & Node.js"
    echo "  - Bun"
    echo "  - All Brewfile dependencies"
    echo ""
    echo -n "Continue? (y/N): "
    read -r confirm
    
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelled"
        exit 0
    fi
    
    install_homebrew
    install_oh_my_zsh
    install_powerlevel10k
    install_nvm
    install_bun
    install_brew_deps
    build_sketchybar_helper
    
    print_header "Bootstrap Complete!"
    echo -e "${GREEN}Next steps:${NC}"
    echo "  1. Run: ${BLUE}cd ~/.dotfiles && ./install.sh${NC}"
    echo "  2. Restart your terminal"
    echo "  3. Configure P10K: ${BLUE}p10k configure${NC}"
}

main
