#!/usr/bin/env bash

set -e

# ============================================
# Colors
# ============================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================
# Configuration
# ============================================
DOTFILES_DIR="$HOME/.dotfiles"
CONFIGS=("zsh" "nvim" "kitty" "git" "sketchybar" "zellij")

# ============================================
# Helper Functions
# ============================================

print_header() {
    echo -e "\n${MAGENTA}================================${NC}"
    echo -e "${MAGENTA}$1${NC}"
    echo -e "${MAGENTA}================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# ============================================
# Prerequisite Checks
# ============================================

check_prerequisites() {
    print_header "Checking Prerequisites"
    
    local missing=()
    
    # Check for stow
    if ! command -v stow &> /dev/null; then
        missing+=("stow")
        print_error "GNU Stow is not installed"
    else
        print_success "GNU Stow found"
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        missing+=("git")
        print_error "Git is not installed"
    else
        print_success "Git found"
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        print_error "\nMissing prerequisites: ${missing[*]}"
        print_info "Install with: brew install ${missing[*]}"
        exit 1
    fi
    
    print_success "\nAll prerequisites satisfied!"
}

# ============================================
# Stow Operations
# ============================================

stow_config() {
    local config=$1
    local action=$2  # "stow" or "unstow"
    
    if [ ! -d "$DOTFILES_DIR/$config" ]; then
        print_warning "Directory $config not found, skipping..."
        return 1
    fi
    
    cd "$DOTFILES_DIR"
    
    if [ "$action" = "stow" ]; then
        if stow -v "$config" 2>&1 | grep -q "LINK"; then
            print_success "Stowed $config"
            return 0
        else
            print_info "$config already stowed or no changes"
            return 0
        fi
    elif [ "$action" = "unstow" ]; then
        if stow -v -D "$config" 2>&1 | grep -q "UNLINK"; then
            print_success "Unstowed $config"
            return 0
        else
            print_info "$config not stowed or no changes"
            return 0
        fi
    fi
}

# ============================================
# Interactive Menu
# ============================================

show_menu() {
    print_header "Dotfiles Installation"
    
    echo -e "${CYAN}Available configurations:${NC}\n"
    
    local i=1
    for config in "${CONFIGS[@]}"; do
        echo -e "  ${GREEN}$i${NC}) $config"
        ((i++))
    done
    
    echo -e "\n  ${GREEN}A${NC}) Install All"
    echo -e "  ${GREEN}U${NC}) Uninstall All"
    echo -e "  ${GREEN}Q${NC}) Quit"
    
    echo -e "\n${YELLOW}Select configurations to install (space-separated numbers, or A/U/Q):${NC}"
    read -r selection
    
    case $selection in
        [Aa])
            install_all
            ;;
        [Uu])
            uninstall_all
            ;;
        [Qq])
            print_info "Exiting..."
            exit 0
            ;;
        *)
            install_selected "$selection"
            ;;
    esac
}

# ============================================
# Installation Functions
# ============================================

install_all() {
    print_header "Installing All Configurations"
    
    for config in "${CONFIGS[@]}"; do
        stow_config "$config" "stow"
    done
    
    post_install_message
}

install_selected() {
    local selection=$1
    print_header "Installing Selected Configurations"
    
    for num in $selection; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#CONFIGS[@]}" ]; then
            local config="${CONFIGS[$((num-1))]}"
            stow_config "$config" "stow"
        else
            print_warning "Invalid selection: $num"
        fi
    done
    
    post_install_message
}

uninstall_all() {
    print_header "Uninstalling All Configurations"
    
    print_warning "This will remove all symlinks created by stow."
    echo -n "Are you sure? (y/N): "
    read -r confirm
    
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        print_info "Uninstall cancelled"
        return
    fi
    
    for config in "${CONFIGS[@]}"; do
        stow_config "$config" "unstow"
    done
    
    print_success "\nAll configurations unstowed!"
}

# ============================================
# Post-Install
# ============================================

post_install_message() {
    print_header "Installation Complete!"
    
    echo -e "${GREEN}Next steps:${NC}\n"
    echo -e "  1. Restart your terminal or run: ${CYAN}source ~/.zshrc${NC}"
    echo -e "  2. Install dependencies: ${CYAN}brew bundle${NC}"
    echo -e "  3. Open Neovim to install plugins: ${CYAN}nvim${NC}"
    echo -e "  4. Configure Powerlevel10k: ${CYAN}p10k configure${NC}"
    echo -e "\n${YELLOW}For help, see: ${CYAN}$DOTFILES_DIR/README.md${NC}\n"
}

# ============================================
# Main
# ============================================

main() {
    # Check if running from dotfiles directory
    if [ ! -d "$DOTFILES_DIR" ]; then
        print_error "Dotfiles directory not found at $DOTFILES_DIR"
        exit 1
    fi
    
    check_prerequisites
    show_menu
}

# Run main if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
