#!/usr/bin/env bash

# Help script - shows quick usage guide

cat << 'EOF'

╔═══════════════════════════════════════════════════════════════╗
║                  📚 DOTFILES QUICK HELP                       ║
╚═══════════════════════════════════════════════════════════════╝

🔧 SCRIPTS:

   ./scripts/bootstrap.sh      First-time setup (new machines)
   ./scripts/update.sh         Update & sync dotfiles
   ./scripts/check-health.sh   Verify system health
   ./scripts/help.sh           Show this help

⚡ MAKEFILE SHORTCUTS:

   make help       Show all make commands
   make install    Interactive installer
   make update     Update dotfiles
   make health     System health check
   make brew       Install Brew packages

📖 DOCUMENTATION:

   README.md                   Main documentation
   QUICK_START.md              One-page cheat sheet
   docs/SCRIPTS_GUIDE.md       Complete scripts guide
   docs/DEPENDENCIES.md        All dependencies
   FIXES.md                    Recent fixes applied

🎯 COMMON TASKS:

   Setup new machine:
   $ ./scripts/bootstrap.sh && ./install.sh

   Update dotfiles:
   $ make update

   Check what's missing:
   $ make health

   Install missing packages:
   $ brew bundle

   Reinstall configs:
   $ ./install.sh

🆘 TROUBLESHOOTING:

   1. Run health check:
      $ ./scripts/check-health.sh

   2. Look for ✗ or ⚠ marks

   3. Install missing items:
      $ brew bundle
      $ ./scripts/bootstrap.sh

   4. Reinstall configs:
      $ ./install.sh

💡 NEOVIM HELP:

   Inside Neovim:
   :Lazy           Plugin manager
   :Mason          LSP/tools
   :checkhealth    Health check
   :LspInfo        LSP status

📚 READ MORE:

   cat docs/SCRIPTS_GUIDE.md   # Detailed guide
   cat QUICK_START.md          # Quick reference
   make help                   # Make commands

╚═══════════════════════════════════════════════════════════════╝

EOF
