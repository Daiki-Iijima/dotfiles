# dotfiles

Daikiの設定ファイル集。シンボリックリンク方式で管理し、複数デバイスで同じ環境を再現する。

## セットアップ

```bash
git clone https://github.com/Daiki-Iijima/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` は既存ファイルを `.bak` にバックアップしてからシンボリックリンクを作成する。

### Gitの初期設定（初回のみ）

```bash
# ~/dotfiles/git/.gitconfig の [user] セクションを編集
git config -f ~/dotfiles/git/.gitconfig user.name "Your Name"
git config -f ~/dotfiles/git/.gitconfig user.email "your@email.com"
```

---

## ツール一覧

### WezTerm

**設定ファイル:** `wezterm/.wezterm.lua` → `~/.wezterm.lua`

Rust製の高速ターミナルエミュレータ。GPU レンダリング対応。tmux の代替としてペイン分割・タブ管理を内蔵している。

**主なキーバインド（Leader = `Ctrl+Space`）**

| キー | 動作 |
|------|------|
| `Leader + \|` | ペイン縦分割 |
| `Leader + -` | ペイン横分割 |
| `Leader + h/j/k/l` | ペイン移動 |
| `Leader + r` | リサイズモード |
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

**設定ファイル:** `nvim/` → `~/.config/nvim/`

Vimベースのモダンなテキストエディタ。Lua で設定を記述し、lazy.nvim でプラグイン管理。

```
nvim/
├── init.lua          # エントリポイント
├── lazy-lock.json    # プラグインのバージョンロック
└── lua/
    ├── settings.lua  # 基本設定
    ├── keymaps.lua   # キーバインド
    ├── plugins/      # プラグイン設定
    └── lang/         # 言語別設定
```

---

### Zsh

**設定ファイル:** `zsh/.zshrc` → `~/.zshrc`

Z Shell の設定。以下のツールと連携している。

| ツール | 役割 |
|--------|------|
| starship | プロンプト表示 |
| zoxide | スマートな `cd`（`z` コマンド）|
| atuin | シェル履歴の検索・管理 |
| fzf | ファジーファインダー（`Ctrl+]` でghqリポジトリ選択）|
| eza | `ls` の代替（アイコン・Git対応）|
| bat | `cat` の代替（シンタックスハイライト）|
| mise | 言語バージョン管理（Node, Python, Go等）|
| yazi | ターミナルファイルマネージャー（`y` コマンド）|
| direnv | ディレクトリ別の環境変数 |

---

### Starship

**設定ファイル:** `starship/starship.toml` → `~/.config/starship.toml`

Rust製の高速・クロスシェルプロンプト。Git状態・言語バージョン・実行時間などを表示。zsh/fish/bash 等あらゆるシェルで同じプロンプトを使える。

---

### Git

**設定ファイル:** `git/.gitconfig` → `~/.gitconfig`

| 設定 | 内容 |
|------|------|
| `core.pager` | delta（diff を美しく表示）|
| `delta.side-by-side` | 横並びで差分表示 |
| `pull.rebase` | pull 時に rebase を使用 |
| `merge.conflictstyle` | diff3 スタイルでコンフリクト表示 |

> **注意:** `[user]` の `name` と `email` はクローン後に各デバイスで設定すること。

---

### Atuin

**設定ファイル:** `atuin/config.toml` → `~/.config/atuin/config.toml`

シェル履歴を SQLite で管理するツール。`Ctrl+R` で高機能な履歴検索UIを表示。複数マシン間で履歴を同期することも可能（要サインアップ）。

主な設定:
- `enter_accept = true` — Enter で即実行、Tab で編集モード

---

### Claude Code

**設定ファイル:** `claude/settings.json` → `~/.claude/settings.json`

Anthropic の AI コーディングアシスタント CLI の設定。

| 設定 | 内容 |
|------|------|
| `model` | 使用モデル（sonnet）|
| `defaultMode` | `acceptEdits`（編集を自動承認）|
| `voiceEnabled` | 音声入力有効 |
| `enabledPlugins` | LSP プラグイン群（Swift, Lua, PHP, TypeScript, Rust, C++）|

> **注意:** `mcpServers.unity-mcp` のパスはマシン固有。Unity を使わない場合はその設定を削除すること。

---

## 依存ツールのインストール（Mac）

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/HEAD/install.sh)"

# ターミナル
brew install --cask wezterm

# フォント（WezTermで使用）
brew install --cask font-jetbrains-mono

# シェルツール
brew install starship zoxide atuin fzf bat eza ripgrep fd git-delta lazygit mise yazi

# Zsh プラグイン
brew install zsh-autosuggestions zsh-syntax-highlighting

# その他
brew install ghq direnv neovim git
```
