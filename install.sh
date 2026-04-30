#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ──────────────────────────────────────────────
# ユーティリティ
# ──────────────────────────────────────────────
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }
error()   { echo "[ERROR] $*" >&2; exit 1; }

# シンボリックリンクを作成（既存ファイルはバックアップ）
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

# WezTerm
link "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

# Zsh
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Neovim
link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Starship
link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Git
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
warn ".gitconfig の [user] セクションに name と email を設定してください"

# Atuin
link "$DOTFILES_DIR/atuin/config.toml" "$HOME/.config/atuin/config.toml"

# Claude Code
link "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"

echo ""
success "Done! 全てのシンボリックリンクを作成しました"
echo ""
echo "次のステップ:"
echo "  1. ~/dotfiles/git/.gitconfig の [user] を編集してください"
echo "     name = YOUR_NAME"
echo "     email = YOUR_EMAIL"
echo "  2. シェルを再起動: exec zsh"
