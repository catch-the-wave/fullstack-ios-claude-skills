#!/usr/bin/env bash
# Bootstrap: configure a new agent to use ~/Skills/
# Usage: bash _bootstrap.sh [agent]
#   agent: claude | codex | pi | cursor | opencode | all (default)
set -euo pipefail

SKILLS_DIR="$HOME/Skills"

agent="${1:-all}"

setup_claude() {
  echo "→ Claude Code"
  rm -rf "$HOME/.claude/skills"
  ln -sf "$SKILLS_DIR" "$HOME/.claude/skills"
  echo "  ✓ $HOME/.claude/skills → $SKILLS_DIR"
}

setup_codex() {
  echo "→ Codex"
  rm -rf "$HOME/.agents/skills"
  ln -sf "$SKILLS_DIR" "$HOME/.agents/skills"
  # Apply codex config
  if [ -f "$SKILLS_DIR/_config/codex.toml" ]; then
    cp "$SKILLS_DIR/_config/codex.toml" "$HOME/.codex/config.toml"
    echo "  ✓ Applied codex config.toml ($(grep -c 'enabled = true' "$SKILLS_DIR/_config/codex.toml") skills enabled)"
  fi
}

setup_pi() {
  echo "→ Pi"
  mkdir -p "$HOME/.pi"
  cat > "$HOME/.pi/settings.json" <<< '{"skills":["~/Skills"]}'
  # Clean old symlinks in .pi/agent/skills/ — keep only orchestration
  find "$HOME/.pi/agent/skills" -maxdepth 1 -type l ! -name "orchestration" -delete 2>/dev/null || true
  echo "  ✓ Pi settings.json → ~/Skills"
}

setup_cursor() {
  echo "→ Cursor"
  rm -rf "$HOME/.cursor/skills" 2>/dev/null
  ln -sf "$SKILLS_DIR" "$HOME/.cursor/skills"
  echo "  ✓ $HOME/.cursor/skills → $SKILLS_DIR"
}

setup_opencode() {
  echo "→ OpenCode"
  rm -rf "$HOME/.config/opencode/skills" 2>/dev/null
  ln -sf "$SKILLS_DIR" "$HOME/.config/opencode/skills"
  echo "  ✓ OpenCode skills → $SKILLS_DIR"
}

# Agent dirs that are likely symlinks already
setup_others() {
  for d in "$HOME/.openclaw" "$HOME/.slate" "$HOME/.kiro" "$HOME/.clawdbot" "$HOME/.bb" "$HOME/.hermes" "$HOME/.factory"; do
    if [ -d "$d" ]; then
      rm -rf "$d/skills" 2>/dev/null
      ln -sf "$SKILLS_DIR" "$d/skills" 2>/dev/null && echo "  ✓ $d/skills → $SKILLS_DIR" || true
    fi
  done
}

echo "Bootstrapping agents to $SKILLS_DIR"
echo ""

case "$agent" in
  all)
    setup_claude
    setup_codex
    setup_pi
    setup_cursor
    setup_opencode
    setup_others
    ;;
  claude) setup_claude ;;
  codex) setup_codex ;;
  pi) setup_pi ;;
  cursor) setup_cursor ;;
  opencode) setup_opencode ;;
  *)
    echo "Unknown agent: $agent"
    echo "Usage: bash _bootstrap.sh [claude|codex|pi|cursor|opencode|all]"
    exit 1
    ;;
esac

echo ""
echo "✓ Done. Restart your agents to pick up the changes."
echo "  To update skills: npx skills update"