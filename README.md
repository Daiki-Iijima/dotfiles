# dotfiles

Daikiの設定ファイル集。シンボリックリンク方式で管理し、複数デバイスで同じ環境を再現する。

## セットアップ

```bash
git clone --recurse-submodules https://github.com/Daiki-Iijima/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Mac / Linux

```bash
./install.sh
```

### Windows (PowerShell を管理者で実行)

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup_windows.ps1
```

### 初回のみ: Git ユーザー設定

`~/.gitconfig.local` が自動生成されるので、name と email を編集する。

```bash
# Mac/Linux
nano ~/.gitconfig.local

# Windows
notepad $HOME\.gitconfig.local
```

---

## ファイル構成

```
dotfiles/
├── wezterm/
│   └── .wezterm.lua        → ~/.wezterm.lua (Mac/Win共通)
├── zsh/
│   └── .zshrc              → ~/.zshrc (Mac/Linux)
├── nvim/                   → ~/.config/nvim (Mac) / %LOCALAPPDATA%\nvim (Win)
│   └── (submodule: Daiki-Iijima/nvim)
├── starship/
│   └── starship.toml       → ~/.config/starship.toml
├── git/
│   └── .gitconfig          → ~/.gitconfig
├── atuin/
│   └── config.toml         → ~/.config/atuin/config.toml
├── claude/
│   └── settings.json       → ~/.claude/settings.json
├── install.sh              # Mac/Linux セットアップ
├── setup_windows.ps1       # Windows セットアップ
└── README.md
```

> **`~/.gitconfig.local`** はdotfilesで管理しない。マシンごとにname/email/credential.helperを設定する。

---

## ツール一覧

### WezTerm

**設定:** `wezterm/.wezterm.lua` → `~/.wezterm.lua`  
**対応:** Mac / Windows / Linux

Rust製の高速ターミナルエミュレータ。GPU レンダリング対応。tmux の代替としてペイン分割・タブ管理を内蔵。

**キーバインド（Leader = `Ctrl+Space`）**

| キー | 動作 |
|------|------|
| `Leader + \|` | ペイン縦分割 |
| `Leader + -` | ペイン横分割 |
| `Leader + h/j/k/l` | ペイン移動 |
| `Leader + r` | リサイズモード（hjklで調整、Escで終了）|
| `Leader + z` | ペインズーム（全画面トグル）|
| `Leader + x` | ペインを閉じる |
| `Leader + c` | 新規タブ |
| `Leader + n/p` | 次/前のタブ |
| `Leader + 1-9` | タブ番号指定 |
| `Leader + ,` | タブ名変更 |
| `Leader + [` | コピーモード |
| `Ctrl + =/-/0` | フォントサイズ変更/リセット |

---

### Neovim

**設定:** `nvim/` (submodule) → `~/.config/nvim` (Mac) / `%LOCALAPPDATA%\nvim` (Win)  
**対応:** Mac / Windows / Linux

Lua で設定を記述し、lazy.nvim でプラグイン管理。設定は [Daiki-Iijima/nvim](https://github.com/Daiki-Iijima/nvim) で独立管理。

---

### Zsh

**設定:** `zsh/.zshrc` → `~/.zshrc`  
**対応:** Mac / Linux（Windowsは WSL2 経由）

| ツール | 役割 |
|--------|------|
| starship | プロンプト表示 |
| zoxide | スマートな `cd`（`z` コマンド）|
| atuin | シェル履歴の検索・管理（`Ctrl+R`）|
| fzf | ファジーファインダー（`Ctrl+]` でghqリポジトリ選択）|
| eza | `ls` の代替（アイコン・Git対応）|
| bat | `cat` の代替（シンタックスハイライト）|
| mise | 言語バージョン管理（Node, Python, Go等）|
| yazi | ターミナルファイルマネージャー（`y` コマンド）|
| direnv | ディレクトリ別の環境変数 |

---

### Starship

**設定:** `starship/starship.toml` → `~/.config/starship.toml`  
**対応:** Mac / Windows / Linux

Rust製の高速クロスシェルプロンプト。Git状態・言語バージョン・実行時間などを表示。

---

### Git

**設定:** `git/.gitconfig` → `~/.gitconfig`  
**対応:** Mac / Windows / Linux

| 設定 | 内容 |
|------|------|
| `core.pager` | delta（diff を美しく表示）|
| `delta.side-by-side` | 横並びで差分表示 |
| `pull.rebase` | pull 時に rebase を使用 |
| `merge.conflictstyle` | diff3 スタイルでコンフリクト表示 |

credential.helper はプラットフォームごとに `~/.gitconfig.local` で管理:

```ini
# Mac
[credential]
    helper = osxkeychain

# Windows
[credential]
    helper = manager
```

---

### Atuin

**設定:** `atuin/config.toml` → `~/.config/atuin/config.toml`  
**対応:** Mac / Windows / Linux

シェル履歴を SQLite で管理。`Ctrl+R` で高機能な履歴検索UIを表示。オプションで複数マシン間の履歴同期も可能。

---

### Claude Code

**設定:** `claude/settings.json` → `~/.claude/settings.json`  
**対応:** Mac / Windows / Linux

| 設定 | 内容 |
|------|------|
| `model` | 使用モデル（sonnet）|
| `defaultMode` | `acceptEdits`（編集を自動承認）|
| `voiceEnabled` | 音声入力有効 |
| `enabledPlugins` | LSP プラグイン群 |

---

## 依存ツールのインストール

### Mac

```bash
# ターミナル・エディタ
brew install --cask wezterm
brew install neovim

# フォント
brew install --cask font-jetbrains-mono

# シェルツール
brew install starship zoxide atuin fzf bat eza ripgrep fd git-delta lazygit mise yazi

# Zsh プラグイン
brew install zsh-autosuggestions zsh-syntax-highlighting

# その他
brew install ghq direnv git
```

### Windows

```powershell
winget install wez.wezterm
winget install Neovim.Neovim
winget install Starship.Starship
winget install sharkdp.bat
winget install eza-community.eza
winget install BurntSushi.ripgrep.MSVC
winget install junegunn.fzf
winget install ajeetdsouza.zoxide
winget install jesseduffield.lazygit
winget install dandavison.delta
winget install junegunn.fzf
```
