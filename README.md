# dotfiles

Daikiの設定ファイル集。シンボリックリンク方式で管理し、Mac / Linux / Windows で同じ環境を再現する。

---

## クイックスタート

```bash
git clone --recurse-submodules https://github.com/Daiki-Iijima/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

その後、OS 別手順へ。

---

## Mac セットアップ

### 1. Xcode CLT
```bash
xcode-select --install
```

### 2. Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. 依存ツール一括導入
```bash
# ターミナル / GUI
brew install --cask ghostty wezterm font-hackgen-nerd

# シェル / プロンプト / 履歴
brew install starship zoxide atuin fzf zsh-autosuggestions zsh-syntax-highlighting

# ファイル系 CLI
brew install bat eza ripgrep fd yazi

# Git / TUI
brew install git gh git-delta lazygit lazydocker lazysql ghq

# エディタ / ターミナル
brew install neovim tmux

# 言語マネージャ
brew install mise

# モニタ / ドキュメント
brew install btop glow

# 任意
brew install --cask karabiner-elements
```

### 4. dotfiles 適用
```bash
cd ~/dotfiles
./install.sh
```
- 既存の同名ファイルは `*.bak` にバックアップされてから symlink 化される。
- `~/.gitconfig.local` が自動生成される。

### 5. ローカル設定
```bash
# Git の name / email
$EDITOR ~/.gitconfig.local
```

### 6. tmux プラグイン (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux start \; source ~/.config/tmux/tmux.conf \; run '~/.tmux/plugins/tpm/scripts/install_plugins.sh'
```
または tmux 起動後に `Ctrl+Space` → `I` (大文字)。

### 7. シェル切替 (必要時)
```bash
chsh -s $(which zsh)
exec zsh
```

---

## Linux セットアップ (Arch / Hyprland 想定)

### 1. ベース
```bash
sudo pacman -Syu --needed base-devel git curl
```

### 2. 依存ツール
```bash
# CLI 必須
sudo pacman -S --needed \
  zsh starship zoxide atuin fzf \
  zsh-autosuggestions zsh-syntax-highlighting \
  bat eza ripgrep fd yazi \
  git github-cli git-delta lazygit lazydocker \
  neovim tmux mise btop glow

# Hyprland デスクトップ環境
sudo pacman -S --needed \
  hyprland waybar fuzzel dunst wlogout \
  ghostty foot wl-clipboard

# AUR (yay 経由)
yay -S lazysql ghq
```

### 3. dotfiles 適用
```bash
cd ~/dotfiles
./install.sh
```
Linux 環境では `hypr / waybar / fuzzel / dunst / wlogout` も自動で symlink される。

### 4. ローカル設定
```bash
$EDITOR ~/.gitconfig.local
```
`credential.helper` は Linux なら `cache` または `libsecret`:
```ini
[credential]
    helper = cache --timeout=3600
# または
    helper = /usr/lib/git-core/git-credential-libsecret
```

### 5. tmux プラグイン
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 6. シェル切替
```bash
chsh -s $(which zsh)
```

---

## Windows セットアップ

### 1. winget で依存導入
```powershell
winget install wez.wezterm Neovim.Neovim Starship.Starship
winget install sharkdp.bat eza-community.eza BurntSushi.ripgrep.MSVC
winget install junegunn.fzf ajeetdsouza.zoxide jesseduffield.lazygit
winget install dandavison.delta sharkdp.fd
```

### 2. dotfiles 適用 (PowerShell 管理者)
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
cd $HOME\dotfiles
.\setup_windows.ps1
```

### 3. ローカル設定
```powershell
notepad $HOME\.gitconfig.local
```
```ini
[credential]
    helper = manager
```

> tmux / yazi / btop / glow / karabiner / Hyprland 系は **Mac/Linux 専用**。Windows では WSL2 上で `install.sh` を別途実行することを推奨。

---

## ファイル構成

```
dotfiles/
├── wezterm/.wezterm.lua       → ~/.wezterm.lua            [Mac/Win/Linux]
├── ghostty/config             → ~/.config/ghostty/config  [Mac/Linux]
├── zsh/.zshrc                 → ~/.zshrc                  [Mac/Linux]
├── tmux/                      → ~/.config/tmux/           [Mac/Linux]
│   ├── tmux.conf
│   └── help-ja.txt
├── nvim/                      → ~/.config/nvim            [submodule]
├── starship/starship.toml     → ~/.config/starship.toml   [全OS]
├── git/.gitconfig             → ~/.gitconfig              [全OS]
├── atuin/config.toml          → ~/.config/atuin/config.toml
├── claude/settings.json       → ~/.claude/settings.json
├── mise/config.toml           → ~/.config/mise/config.toml
├── yazi/                      → ~/.config/yazi/           [Mac/Linux]
├── btop/btop.conf             → ~/.config/btop/btop.conf  [Mac/Linux]
├── glow/glow.yml              → ~/.config/glow/glow.yml   [Mac/Linux]
├── karabiner/karabiner.json   → ~/.config/karabiner/...   [Mac only]
├── hypr/ waybar/ fuzzel/      → ~/.config/...             [Linux only]
├── dunst/ wlogout/            → ~/.config/...             [Linux only]
├── install.sh                 # Mac/Linux セットアップ
├── setup_windows.ps1          # Windows セットアップ
└── README.md
```

> `~/.gitconfig.local` はマシン固有で、dotfiles では管理しない。

---

## tmux ショートカット (Prefix = `Ctrl+Space`)

| キー | 動作 |
|------|------|
| `Prefix + ?` | 日本語ヘルプ (popup) |
| `Prefix + r` | config 再読込 |
| `Prefix + \|` / `-` | ペイン縦/横分割 |
| `Prefix + h/j/k/l` | ペイン移動 |
| `Prefix + H/J/K/L` | ペインリサイズ (連打可) |
| `Ctrl + h/j/k/l` | nvim と統合してプレフィックス無し移動 |
| `Prefix + c` | 新ウィンドウ (現dir) |
| `Prefix + Enter` / `[` | コピーモード |
| `v` (copy-mode) | 選択開始 |
| `y` (copy-mode) | コピー (`pbcopy` / `wl-copy` 等システム連携) |
| **`Prefix + T`** | **tmux-thumbs** 画面の URL/path を選んでコピー |
| **大文字キー** (thumbs内) | コピー + `open` (URLならブラウザで開く) |
| `Prefix + f` | tmux-fzf (セッション/ウィンドウ切替) |

---

## ツール一覧

### WezTerm / Ghostty
GPU レンダ対応の高速ターミナル。WezTerm は全OS、Ghostty は Mac/Linux。

### Neovim
Lua + lazy.nvim。設定は [Daiki-Iijima/nvim](https://github.com/Daiki-Iijima/nvim) submodule。

### Zsh
| ツール | 役割 |
|--------|------|
| starship | プロンプト |
| zoxide  | スマート `cd` (`z`) |
| atuin   | 履歴検索 (`Ctrl+R`) |
| fzf     | ファジーファインダー (`Ctrl+]` で ghq) |
| eza     | `ls` 代替 |
| bat     | `cat` 代替 |
| mise    | 言語バージョン管理 |
| yazi    | TUI ファイラ (`y`) |
| direnv  | dir 別環境変数 |

### tmux
セッション / ペイン管理。catppuccin テーマ + resurrect/continuum で 15 分毎に自動セッション保存。

### Git
- delta による綺麗な diff
- `pull.rebase = true`
- `commit.gpgsign = false` (個別マシンで有効化したい場合は `~/.gitconfig.local` で `gpgsign = true` 上書き)

### Atuin
SQLite ベース履歴 + マシン間同期 (option)。

### Claude Code
LSP プラグイン群、ECC・caveman・vercel 等のマーケットプレイス設定込み。

---

## 同期方針メモ

- **共通設定** はすべて symlink で `~/dotfiles` 配下に集約 → repo を pull すれば全マシン同期。
- **マシン固有** (`~/.gitconfig.local`、SSH 鍵、API トークン) は repo に入れない。
- **シークレット類** (`gh hosts.yml`、`.env`) は対象外。秘密管理は別 (Bitwarden / 1Password / age 暗号化) で。

---

## 既知の制限

- tmux プラグイン (TPM) は別途 `git clone` 必要。
- Neovim プラグインは初回起動時 `lazy.nvim` が自動同期。
- mise の language ランタイムは `mise install` で別途取得。
- Ghostty/yazi/btop の theme などは現状管理対象外 (必要時追加)。
