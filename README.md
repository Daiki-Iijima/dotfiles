# 各ドットファイルをGitHubで管理する
## Macのドットファイルの管理の仕方
シンボリックリンクを作成して、ドットファイル本体は、Git管理しているフォルダの別ファイルを作成する
- シンボリックリンクの作成ファイルの移動
```
mkdir ./dotfiles
cd ~
mv .vimrc ./dotfiles/_vimrc
ln ./dotfile/_vimrc ./.vimrc
```
