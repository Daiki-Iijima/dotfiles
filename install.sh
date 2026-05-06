#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ──────────────────────────────────────────────
# ユーティリティ
# ──────────────────────────────────────────────
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }

link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    warn "Backing up existing file: $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  success "Linked: $dest -> $src"
}

# ──────────────────────────────────────────────
# シンボリックリンク作成
# ──────────────────────────────────────────────
info "Setting up dotfiles from $DOTFILES_DIR"

# 共通 (Mac / Linux)
link "$DOTFILES_DIR/wezterm/.wezterm.lua"    "$HOME/.wezterm.lua"
link "$DOTFILES_DIR/zsh/.zshrc"              "$HOME/.zshrc"
link "$DOTFILES_DIR/nvim"                    "$HOME/.config/nvim"
link "$DOTFILES_DIR/starship/starship.toml"  "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/git/.gitconfig"          "$HOME/.gitconfig"
link "$DOTFILES_DIR/atuin/config.toml"       "$HOME/.config/atuin/config.toml"
link "$DOTFILES_DIR/claude/settings.json"    "$HOME/.claude/settings.json"
link "$DOTFILES_DIR/mise/config.toml"        "$HOME/.config/mise/config.toml"
link "$DOTFILES_DIR/tmux/tmux.conf"          "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES_DIR/tmux/help-ja.txt"        "$HOME/.config/tmux/help-ja.txt"
link "$DOTFILES_DIR/ghostty/config"          "$HOME/.config/ghostty/config"
link "$DOTFILES_DIR/yazi/yazi.toml"          "$HOME/.config/yazi/yazi.toml"
link "$DOTFILES_DIR/yazi/open.toml"          "$HOME/.config/yazi/open.toml"
link "$DOTFILES_DIR/btop/btop.conf"          "$HOME/.config/btop/btop.conf"
link "$DOTFILES_DIR/glow/glow.yml"           "$HOME/.config/glow/glow.yml"

# Mac 専用
if [ "$(uname)" = "Darwin" ]; then
  link "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
fi

# Hyprland 系 (Linux のみ)
if [ "$(uname)" = "Linux" ]; then
  link "$DOTFILES_DIR/hypr"     "$HOME/.config/hypr"
  link "$DOTFILES_DIR/waybar"   "$HOME/.config/waybar"
  link "$DOTFILES_DIR/fuzzel"   "$HOME/.config/fuzzel"
  link "$DOTFILES_DIR/dunst"    "$HOME/.config/dunst"
  link "$DOTFILES_DIR/wlogout"  "$HOME/.config/wlogout"
fi

# ──────────────────────────────────────────────
# ~/.gitconfig.local (マシン固有設定)
# ──────────────────────────────────────────────
LOCAL_GIT="$HOME/.gitconfig.local"
if [ ! -f "$LOCAL_GIT" ]; then
  cat > "$LOCAL_GIT" <<EOF
[user]
	name = YOUR_NAME
	email = YOUR_EMAIL
[credential]
	helper = osxkeychain
EOF
  warn "Created $LOCAL_GIT — name と email を設定してください"
else
  info "$LOCAL_GIT は既に存在します (スキップ)"
fi

echo ""
success "Done! 全てのシンボリックリンクを作成しました"
echo ""
echo "次のステップ:"
echo "  1. ~/.gitconfig.local の name と email を編集してください"
echo "  2. シェルを再起動: exec zsh"
