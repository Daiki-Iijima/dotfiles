set number
set cursorline
set virtualedit=onemore
set autoindent 		" インデントを自動で調整してくれる
set laststatus=2 "ステータスバーの常時表示

syntax on	" enableでも設定はできるらしい

"tab入力した時のスペース入力数を変更する
set tabstop=2

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :wq<CR> 
nnoremap <S-h> ^
nnoremap <S-l> $
