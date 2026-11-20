#!/usr/bin/env bash
# Everything herdr/.config/herdr/config.toml assumes but stow can't provide:
# the config symlink (herdr writes a stub config on first launch, which blocks stow),
# the plugins behind the prefix+space / prefix+e / prefix+f bindings, the agent
# logo font, and the agent-state integrations. Safe to re-run.

set -euo pipefail
cd "$(dirname "$0")/.."

command -v herdr >/dev/null || { echo "herdr not found: brew install herdr" >&2; exit 1; }

cfg="$HOME/.config/herdr/config.toml"
if [[ -e $cfg && ! -L $cfg ]]; then
	mv "$cfg" "$cfg.pre-stow.bak"
	echo "moved herdr's generated config to $cfg.pre-stow.bak"
fi
stow herdr

font="$HOME/Library/Fonts/HerdrAgentIconsMax-Regular.ttf"
[[ -f $font ]] || curl -fsSL -o "$font" \
	https://raw.githubusercontent.com/hhdebb/herdr-radar/main/dist/HerdrAgentIconsMax-Regular.ttf

installed=$(herdr plugin list)
for plugin in jeffarese/herdr-bar ChmaraX/herdr-nvim; do
	grep -qi "${plugin#*/}" <<<"$installed" || herdr plugin install -y "$plugin"
done

# Only for agents that are actually on this machine (matches pick-agent's list).
for agent in claude opencode codex; do
	command -v "$agent" >/dev/null && herdr integration install "$agent"
done

# agent-wt (herdr/.config/herdr/agent-wt): global Claude hooks that only act inside its worktrees,
# permission to keep its status file, and a headless browser so agents can check their own UI.
# --isolated keeps each agent's browser profile in memory so parallel agents don't collide.
settings="$HOME/.claude/settings.json"
[[ -f $settings ]] || echo '{}' >"$settings"
jq '
  def without_ours: map(select(any(.hooks[]?; .command | contains("agent-wt")) | not));
  .hooks.SessionStart = ((.hooks.SessionStart // []) | without_ours)
      + [{hooks: [{type: "command", command: "$HOME/.config/herdr/agent-wt brief"}]}]
  | .hooks.Stop = ((.hooks.Stop // []) | without_ours)
      + [{hooks: [{type: "command", command: "$HOME/.config/herdr/agent-wt verify", timeout: 600}]}]
  | .permissions.allow = ((.permissions.allow // []) + ["Read(~/.local/state/agent-wt/**)", "Edit(~/.local/state/agent-wt/**)"] | unique)
' "$settings" >"$settings.tmp" && mv "$settings.tmp" "$settings"
if command -v claude >/dev/null && ! claude mcp get playwright >/dev/null 2>&1; then
	claude mcp add -s user playwright -- npx -y @playwright/mcp@latest --headless --isolated
fi

herdr server reload-config >/dev/null 2>&1 || true # no server running is fine
echo "herdr ready. Restart kitty once so it picks up the icon font."
