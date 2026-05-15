.PHONY: help install update health brew bootstrap clean stow-all unstow-all theme

# Default target
help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Targets:"
	@echo "  install    - Run interactive installation"
	@echo "  bootstrap  - Install all dependencies from scratch"
	@echo "  update     - Pull latest changes and restow"
	@echo "  health     - Check system health and dependencies"
	@echo "  brew       - Install Homebrew dependencies"
	@echo "  stow-all   - Stow all configurations"
	@echo "  unstow-all - Unstow all configurations"
	@echo "  theme      - Render theme/colors.sh into all tool configs"
	@echo "  clean      - Remove all symlinks"
	@echo "  help       - Show this help message"

install:
	@./install.sh

bootstrap:
	@./scripts/bootstrap.sh

update:
	@./scripts/update.sh

health:
	@./scripts/check-health.sh

brew:
	@brew bundle

theme:
	@./scripts/apply-theme.sh

stow-all:
	@stow zsh nvim kitty git sketchybar zellij lazygit

unstow-all:
	@stow -D zsh nvim kitty git sketchybar zellij lazygit

clean: unstow-all
	@echo "All configurations unstowed"

# Build sketchybar helper
sketchybar-helper:
	@cd sketchybar/.config/sketchybar/helper && $(MAKE)
