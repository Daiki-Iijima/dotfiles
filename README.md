# dotfiles (chezmoi)

Daikiの設定ファイル集。**[chezmoi](https://www.chezmoi.io)** で Mac / Linux / Windows を同期。

機微情報は **age 暗号化** で repo に格納、復号鍵は **Bitwarden** に保管。

---

## クイックスタート

### 0. age 秘密鍵を Bitwarden から取得

新マシンでは最初に age 秘密鍵が必要 (これがないと暗号化ファイルが復号できない):

1. Bitwarden Desktop / Web Vault にログイン
2. `chezmoi-age-key` アイテムの Attachments から `key.txt` をダウンロード
3. 配置:
   ```bash
   mkdir -p ~/.config/chezmoi
   mv ~/Downloads/key.txt ~/.config/chezmoi/key.txt
   chmod 600 ~/.config/chezmoi/key.txt
   ```

### 1. chezmoi インストール

#### Mac
```bash
brew install chezmoi
```

#### Linux (Arch)
```bash
sudo pacman -S chezmoi
# AUR: yay -S chezmoi-bin
```

#### Linux (汎用)
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
```

#### Windows
```powershell
winget install twpayne.chezmoi
# or scoop install chezmoi
```

### 2. 初期化 + 適用

```bash
chezmoi init https://github.com/Daiki-Iijima/dotfiles.git
chezmoi apply
```

`chezmoi init` で repo を `~/.local/share/chezmoi/` に clone し、`apply` で `$HOME` に展開する。

依存ツールは初回 apply 時に `run_once_before_10-install-*-deps.sh` が自動実行される (Mac/Linux)。Windows は `run_once_before_10-install-windows-deps.ps1` (PowerShell 管理者推奨)。

### 3. 初回マシン固有設定

```bash
$EDITOR ~/.gitconfig.local   # name / email / credential.helper
exec zsh                     # シェル再起動
```

---

## 日常運用

| 操作 | コマンド |
|------|----------|
| 差分確認 | `chezmoi diff` |
| 適用 | `chezmoi apply` |
| 編集 (source側) | `chezmoi edit ~/.zshrc` |
| ターゲット直接編集を取込 | `chezmoi re-add` |
| pull + apply | `chezmoi update` |
| source dir に移動 | `chezmoi cd` |
| 状態 | `chezmoi status` |
| 新規取込 | `chezmoi add ~/.foo` |
| 暗号化取込 | `chezmoi add --encrypt ~/.ssh/some_key` |

---

## ディレクトリ構成

```
~/.local/share/chezmoi/                  # chezmoi source dir
├── dot_zshrc                            → ~/.zshrc
├── dot_wezterm.lua                      → ~/.wezterm.lua
├── dot_gitconfig                        → ~/.gitconfig
├── dot_ssh/
│   ├── id_ed25519.pub                   → ~/.ssh/id_ed25519.pub      (平文)
│   ├── encrypted_private_id_ed25519.age → ~/.ssh/id_ed25519          (暗号化)
│   ├── encrypted_private_config.age     → ~/.ssh/config              (暗号化)
│   ├── allowed_signers                  → ~/.ssh/allowed_signers
│   └── (project-specific keys, 暗号化)
├── dot_claude/settings.json             → ~/.claude/settings.json
├── private_dot_config/
│   ├── starship.toml, atuin/, mise/, tmux/, ghostty/, yazi/, btop/, glow/
│   ├── private_karabiner/               (Mac only, .chezmoiignore で制御)
│   └── (Linux: hypr/, waybar/, fuzzel/, dunst/, wlogout/)
├── .chezmoiignore.tmpl                  # OS別の除外ルール
├── .chezmoiexternal.toml.tmpl           # nvim を別repoから取得
├── run_once_before_10-install-macos-deps.sh.tmpl
├── run_once_before_10-install-linux-deps.sh.tmpl
└── run_once_before_10-install-windows-deps.ps1.tmpl
```

### chezmoi 命名規約 早見

| プレフィックス | 意味 |
|---|---|
| `dot_X` | `~/.X` |
| `private_X` | パーミッション 0600 |
| `executable_X` | +x |
| `encrypted_X` | age/gpg 暗号化、apply 時に復号 |
| `run_once_X` | 1度だけ実行されるスクリプト (内容変わると再実行) |
| `run_once_before_X` | apply 前に実行 |
| `*.tmpl` | Goテンプレート、apply 時に展開 |

---

## 暗号化されているもの

age で暗号化 (秘密鍵: `~/.config/chezmoi/key.txt`、Bitwarden保管):

- `~/.ssh/id_ed25519` (メイン秘密鍵)
- `~/.ssh/config` (ホスト設定)
- `~/.ssh/{ci,dxsite,yamato,mirarista,mirarista-web-platform,misc}/*` (プロジェクトdeploy keys)

公開鍵 (`*.pub`、`allowed_signers`) は平文。

### 暗号化ファイルを追加するとき
```bash
chezmoi add --encrypt ~/.ssh/new_key
```

### 鍵をローテーションしたいとき
1. age 鍵再生成
2. chezmoi.toml の `recipient` 更新
3. すべての `encrypted_*.age` を再暗号化 (`chezmoi re-add`)
4. 新しい秘密鍵を Bitwarden 更新

---

## 同期の流れ

```
Mac (このマシン)
   ↓ chezmoi add / chezmoi re-add
~/.local/share/chezmoi/  (git repo, push origin main)
   ↓ git push
github.com/Daiki-Iijima/dotfiles
   ↓ git pull (chezmoi update)
Linux / Windows / 他Mac
   ↓ chezmoi apply
各マシンの $HOME
```

---

## tmux ショートカット (Prefix = `Ctrl+Space`)

| キー | 動作 |
|------|------|
| `Prefix + ?` | 日本語ヘルプ (popup) |
| `Prefix + r` | config 再読込 |
| `Prefix + \|` / `-` | ペイン縦/横分割 |
| `Prefix + h/j/k/l` | ペイン移動 |
| `Prefix + H/J/K/L` | ペインリサイズ (連打可) |
| `Ctrl + h/j/k/l` | nvim統合移動 |
| `Prefix + c` | 新ウィンドウ (現dir) |
| `Prefix + Enter` / `[` | コピーモード |
| `v` (copy-mode) | 選択開始 |
| `y` (copy-mode) | コピー (`pbcopy` / `wl-copy` 等) |
| `Prefix + T` | tmux-thumbs (URL/path 抽出) |
| 大文字キー (thumbs内) | コピー + `open` |
| `Prefix + f` | tmux-fzf |

---

## トラブルシュート

### `chezmoi apply` で復号エラー
- `~/.config/chezmoi/key.txt` が無い、または public key が `chezmoi.toml` の recipient と一致しない
- → Bitwarden から `key.txt` を取り直す、または age鍵を再生成して全体 re-encrypt

### `~/.gitconfig.local` の name が `YOUR_NAME` のまま
- → 編集してから git commit してください (commit-msg hook で警告等は付けてない)

### `run_once_before_*` が再実行されてしまう
- `chezmoi state` でスクリプト hash を確認: `chezmoi state get-bucket scriptState`
- 内容が変わると再実行される (idempotent に書いてあるので問題はない)

### Linux / Windows で `karabiner` が消える
- `.chezmoiignore.tmpl` で OS 判定して除外している
- 想定動作

---

## 旧運用 (bash install.sh) からの移行

`backup-bash-install` ブランチに旧運用を保管。必要なら参照。
復元: `git checkout backup-bash-install`

---

## 参考リンク

- [chezmoi 公式](https://www.chezmoi.io)
- [age (暗号化)](https://github.com/FiloSottile/age)
- [Bitwarden CLI](https://bitwarden.com/help/cli/)
