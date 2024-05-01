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

## Windowsのドットファイルの管理の仕方

シンボリックリンクを作成して、ドットファイル本体は、Git管理しているフォルダの別ファイルを作成する
Windowsの場合、ファイルの先頭は`.`ではなく`_`を使う

### Windows環境のシンボリックリンクの作成方法

TODO : 追記

#### 1. ユーザーディレクトリにリポジトリをクローン

```bash
cd C:\Users\DaikiIijima\
git clone https://github.com/Daiki-Iijima/dotfiles.git dotfiles
```

#### 2. シンボリックリンクを作成

シンボリックリンクの作成は、`mklink`コマンドを使用します。`コマンドプロンプトを管理者モード`で使用してください。

- コマンド解説

  ```bash
  mklink リンク先 リンク元
  ```

実際に実行するコマンド

```bash
cd C:\Users\DaikiIijima\
mklink  .\_vimrc .\dotfiles\_vimrc
```

- 一連の手順

  ```bash
  cd C:\Users\DaikiIijima\
  git clone https://github.com/Daiki-Iijima/dotfiles.git dotfiles
  ```
