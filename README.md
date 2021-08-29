# 各ドットファイルをGitHubで管理する
## Macのドットファイルの管理の仕方
シンボリックリンクを作成して、ドットファイル本体は、Git管理しているフォルダの別ファイルを作成する
### シンボリックリンクの作成方法
dotfilesというフォルダにこのリポジトリをクローンする
```
mkdir ./dotfiles
cd ~
mv .vimrc ./dotfiles/_vimrc
ln ./dotfile/_vimrc ./.vimrc
```

## Windowsのドットファイルの管理の仕方
シンボリックリンクを作成して、ドットファイル本体は、Git管理しているフォルダの別ファイルを作成する
Windowsの場合、ファイルの先頭は`.`ではなく`_`を使う

### シンボリックリンクの作成方法
#### 1. ユーザーディレクトリにリポジトリをクローン
```
cd C:\Users\DaikiIijima\
git clone https://github.com/Daiki-Iijima/dotfiles.git dotfiles
```

#### 2. シンボリックリンクを作成
シンボリックリンクの作成は、`mklink`コマンドを使用します。`コマンドプロンプトを管理者モード`で使用してください。

- コマンド解説
  ```
  mklink リンク先 リンク元
  ```

実際に実行するコマンド
```
cd C:\Users\DaikiIijima\
mklink  .\_vimrc .\dotfiles\_vimrc
```

- 一連の手順
  ```
  cd C:\Users\DaikiIijima\
  git clone https://github.com/Daiki-Iijima/dotfiles.git dotfiles
  ```
