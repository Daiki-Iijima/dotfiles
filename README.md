# 各ドットファイルをGitHubで管理する

## 各ファイルの説明

### 設定ファイル

- _gvimrc : KaoriYa Vim用の設定ファイル(このままでOK)
  - [公式サイト](https://www.kaoriya.net/software/vim/)
- _vimrc : Vim用の設定ファイル(.vimrcに変更が必要)
- _vsvimrc : Visual Studio用の設定ファイル(このままでOK)
- .ideavimrc : IntelliJ IDEA用の設定ファイル(このままでOK)

### AHK用のスクリプト

- AHKv1.ahk : AutoHotKeyのスクリプトファイル(AutoHotKey v1用)
- AHKv2.ahk : AutoHotKeyのスクリプトファイル(AutoHotKey v2用)

## AHKの設定ファイルの配置場所

AHKはWindows専用のツールなので、Windows環境での操作を想定しています。

1. Windows + Rキーを押して、`shell:startup`を入力して、Enterキーを押す
2. 自動で起動させたいファイルを配置する

- Version1の場合 : AHKv1.ahk
- Version2の場合 : AHKv2.ahk

基本は新しい環境ならVersion2でいいはず

## Macのドットファイルの管理の仕方

シンボリックリンクを作成して、ドットファイル本体は、Git管理しているフォルダの別ファイルを作成する

### Mac環境のシンボリックリンクの作成方法

dotfilesというフォルダにこのリポジトリをクローンする

```bash
mkdir ./dotfiles
cd ~
mv .vimrc ./dotfiles/_vimrc
ln ./dotfile/_vimrc ./.vimrc
```

## Windows

シンボリックリンクを作成して管理する

現在のバッチで対応しているのは、以下のファイル

- ホームディレクトリ
  - _vsvimrc : Visual Studio用
  - .ideavimrc : IntelliJ IDEA用
- スタートアップディレクトリ
  - AHKv2.ahk : AutoHotKeyのスクリプトファイル

### コマンド

Cloneしたディレクトリに移動した後、以下の`bat`を`管理者権限`で実行する

- setup_symlinks.bat

### 注意

Gitを通すと改行コードが変わる可能性があるので`CRLF`に変更してから、batファイルを実行すること

エラーになって文字化けする
