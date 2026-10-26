# ============================================
# Oh-My-Zsh Configuration
# ============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Secrets (tokens, keys) live here, never in this repo.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ============================================
# Aliases
# ============================================
alias vim="nvim"
alias fuzzy='fzf --preview "cat {}" | xargs -r nvim'

# ============================================
# Functions
# ============================================
zj() {
    zellij attach --create "${PWD:t}"
}

# Lazygit reads config from ~/Library/Application Support/lazygit on macOS by
# default; point it at the stowed ~/.config/lazygit location instead.
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

# ============================================
# Planned Codebase
# ============================================
PLANNED_REPO="$HOME/planned/entr-clients-cloudfunctions/"

# Auto-pull on terminal open, in the background so the prompt doesn't wait on the network.
if [ -d "$PLANNED_REPO" ]; then
  (git -C "$PLANNED_REPO" pull --quiet &>/dev/null &)
fi

alias update-code="git -C $PLANNED_REPO pull"

# ============================================
# PATH Configuration
# ============================================
# Go binaries
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    export PATH="$PATH:$HOME/go/bin"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Doom Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"

# Local binaries (includes cua-driver-rs)
export PATH="$HOME/.local/bin:$PATH"

# Google Cloud SDK
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# ============================================
# Node / Dev Environment
# ============================================
export DOTENV_ENV=development

# No global NODE_OPTIONS heap bump: it let every node process (tsserver, dev servers, Claude's LSPs)
# grow to 8GB each. Use it only for a command that actually OOMs, e.g.  bigheap pnpm build
bigheap() { NODE_OPTIONS="--max-old-space-size=8192" "$@"; }

# Increase file watcher limit + force polling mode for Next.js dev servers. On this monorepo
# Turbopack's Watchpack hits the macOS fs.watch limit during startup even with ulimit raised,
# producing EMFILE floods and routes failing to register. Polling eliminates the fd pressure
# (small CPU trade) and keeps dev reliable.
ulimit -n 65536
export WATCHPACK_POLLING=true
export CHOKIDAR_USEPOLLING=true

# fnm goes last so the Node it picks (.nvmrc / engines, default 24) wins over anything prepended
# above — ~/.local/bin carries a hermes-installed Node 26 that otherwise shadows it.
# Replaces nvm, which cost ~0.5s per shell.
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines --shell zsh)"
