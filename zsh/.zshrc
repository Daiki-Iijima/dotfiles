# ---- tmux 自動起動 -----------------------------------------------
if [[ -z "$TMUX" && -n "$PS1" && -x "$(command -v tmux)" ]]; then
  exec tmux new-session -A -s main
fi

# ---- Zsh Options -----------------------------------------------
setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt CORRECT
HISTSIZE=10000
SAVEHIST=10000

# man のシンタックスハイライト (colored-man-pages 相当)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


# ---- ターミナルフロー制御を無効化 (Ctrl+Space を tmux prefix として使うため) --
stty -ixon 2>/dev/null

# ---- Locale (日本語) --------------------------------------------
export LANG=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8


# ---- Paths / Env ------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/go"

path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/llvm/bin
  /usr/local/bin
  "$GOPATH/bin"
  "$HOME/.local/bin"
  "$HOME/.antigravity/antigravity/bin"
  $path
)
typeset -U path   # PATH の重複エントリを自動除去
export PATH

# ---- Zsh Completions -------------------------------------------
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -Uz compinit && compinit

# ---- Zsh Plugins -----------------------------------------------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# ---- mise (言語バージョンマネージャー) --------------------------
eval "$(mise activate zsh)"


# ---- fzf オプション ---------------------------------------------
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
"

# Ctrl-]: ghq 管理リポジトリに移動（git status プレビュー）
function ghq-cd-widget() {
  local dir
  local original_buffer="$BUFFER"
  local original_cursor="$CURSOR"

  dir=$(
    ghq list -p | fzf \
      --prompt='repo> ' \
      --with-nth=-2.. \
      --delimiter='/' \
      --preview='git -C {} status --porcelain=v1 -b' \
      --preview-window=right:60%
  )

  if [[ -z "$dir" ]]; then
    BUFFER="$original_buffer"
    CURSOR="$original_cursor"
    zle redisplay
    return
  fi

  BUFFER="cd ${(q)dir}"
  zle accept-line
}
zle -N ghq-cd-widget
bindkey '^]' ghq-cd-widget


# ---- Aliases ----------------------------------------------------
alias gcd='cd "$(ghq list -p | fzf --prompt="ghq> ")"'

# eza (モダンな ls)
alias ls='eza --icons'
alias ll='eza -l --icons --git --time-style="+%Y-%m-%d %H:%M"'
alias la='eza -la --icons --git --time-style="+%Y-%m-%d %H:%M"'
alias lt='eza --tree --icons --level=2'
alias llt='eza -l --tree --icons --git --level=2'

# bat (シンタックスハイライト付き cat)
alias cat='bat --paging=never'
alias less='bat'

# ポート使用状況の一覧
alias ports='lsof -iTCP -sTCP:LISTEN -P -n | awk "NR>1{printf \"%-12s %-6s %s\n\", \$1, \$3, \$9}" | sort -t: -k2 -n | uniq'


# ---- zoxide (スマートな cd) ------------------------------------
eval "$(zoxide init zsh)"


# ---- atuin (シェル履歴管理) ------------------------------------
eval "$(atuin init zsh)"


# ---- direnv (ディレクトリ別環境変数) ----------------------------
eval "$(direnv hook zsh)"


# ---- yazi: 終了時にそのディレクトリへ移動する関数 ---------------
function y() {
  local tmp="$(mktemp -t "yazi-cwd")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ---- navi (インタラクティブチートシート) - 遅延読み込み ----------
function _navi_lazy_init() {
  unfunction _navi_lazy_init
  eval "$(navi widget zsh)"
  zle _navi_widget
}
zle -N _navi_lazy_init
bindkey '^G' _navi_lazy_init


# ---- starship プロンプト (最後に評価) ---------------------------
eval "$(starship init zsh)"

alias claude-mem='bun "/Users/daiki/.claude/plugins/cache/thedotmack/claude-mem/12.1.1/scripts/worker-service.cjs"'
