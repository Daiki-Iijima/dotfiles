# setup_windows.ps1
# 管理者権限で実行してください
# Run as Administrator: Right-click PowerShell -> "Run as Administrator"

param(
  [switch]$Force
)

$DOTFILES = Split-Path -Parent $MyInvocation.MyCommand.Path
$ErrorActionPreference = "Stop"

function Write-Info    { param($msg) Write-Host "[INFO]  $msg" -ForegroundColor Cyan }
function Write-Success { param($msg) Write-Host "[OK]    $msg" -ForegroundColor Green }
function Write-Warn    { param($msg) Write-Host "[WARN]  $msg" -ForegroundColor Yellow }

function New-Link {
  param($src, $dest)

  $parent = Split-Path -Parent $dest
  if (-not (Test-Path $parent)) {
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
  }

  if (Test-Path $dest) {
    $item = Get-Item $dest -Force
    if ($item.LinkType -eq "SymbolicLink") {
      Remove-Item $dest -Force
    } else {
      $bak = "$dest.bak"
      Rename-Item $dest $bak -Force
      Write-Warn "Backed up: $dest -> $bak"
    }
  }

  # ディレクトリかファイルかで引数が違う
  if (Test-Path $src -PathType Container) {
    New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
  } else {
    New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null
  }

  Write-Success "Linked: $dest -> $src"
}

# ──────────────────────────────────────────────
# 管理者権限チェック
# ──────────────────────────────────────────────
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
  Write-Host "[ERROR] 管理者権限が必要です。PowerShellを右クリックして '管理者として実行' してください。" -ForegroundColor Red
  exit 1
}

Write-Info "Setting up dotfiles from $DOTFILES"

# ──────────────────────────────────────────────
# シンボリックリンク作成
# ──────────────────────────────────────────────

# WezTerm (パスはMacと同じ)
New-Link "$DOTFILES\wezterm\.wezterm.lua" "$HOME\.wezterm.lua"

# Neovim (Windowsは AppData\Local\nvim)
New-Link "$DOTFILES\nvim" "$env:LOCALAPPDATA\nvim"

# Starship
New-Link "$DOTFILES\starship\starship.toml" "$HOME\.config\starship.toml"

# Git
New-Link "$DOTFILES\git\.gitconfig" "$HOME\.gitconfig"

# Atuin
New-Link "$DOTFILES\atuin\config.toml" "$HOME\.config\atuin\config.toml"

# Claude Code
New-Link "$DOTFILES\claude\settings.json" "$HOME\.claude\settings.json"

# ──────────────────────────────────────────────
# ~/.gitconfig.local (マシン固有設定)
# ──────────────────────────────────────────────
$localGit = "$HOME\.gitconfig.local"
if (-not (Test-Path $localGit)) {
  @"
[user]
	name = YOUR_NAME
	email = YOUR_EMAIL
[credential]
	helper = manager
"@ | Out-File -FilePath $localGit -Encoding utf8NoBOM
  Write-Warn "Created $localGit — name と email を設定してください"
} else {
  Write-Info "$localGit は既に存在します (スキップ)"
}

# ──────────────────────────────────────────────
# 完了
# ──────────────────────────────────────────────
Write-Host ""
Write-Success "Done! 全てのシンボリックリンクを作成しました"
Write-Host ""
Write-Host "次のステップ:"
Write-Host "  1. $HOME\.gitconfig.local の name と email を編集してください"
Write-Host "  2. WezTermを再起動してください"
Write-Host ""
Write-Host "推奨インストール (winget):"
Write-Host "  winget install wez.wezterm"
Write-Host "  winget install Neovim.Neovim"
Write-Host "  winget install Starship.Starship"
Write-Host "  winget install sharkdp.bat"
Write-Host "  winget install eza-community.eza"
Write-Host "  winget install BurntSushi.ripgrep.MSVC"
Write-Host "  winget install junegunn.fzf"
Write-Host "  winget install ajeetdsouza.zoxide"
Write-Host "  winget install jesseduffield.lazygit"
Write-Host "  winget install dandavison.delta"
