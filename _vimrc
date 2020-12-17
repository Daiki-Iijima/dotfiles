set number				" 行番号を表示する
set cursorline		" カーソルのある位置を強調表示する
set virtualedit=onemore		" カーソル移動を末尾の次の位置まで移動できるようにする
set autoindent 		" インデントを自動で調整してくれる
set laststatus=2 "ステータスバーの常時表示

syntax on	" シンタックスハイライトを有効にする(enableでも設定はできるらしい)

set tabstop=2 "tab入力した時のスペース入力数を変更する

let mapleader = "\<Space>" " スペースキーをショートカットのトリガーとして認識するように設定

" ノーマルモードでのキーバインドの追加
" Space + w (上書き保存)
nnoremap <Leader>w :w<CR> 
" Space + wq (上書き保存してvimを抜ける)
nnoremap <Leader>x :wq<CR> 
" Shift + h (今カーソルがある行の末尾に移動する)
nnoremap <S-h> ^
" Shift + l (今カーソルがある行の先頭に移動する)
nnoremap <S-l> $
