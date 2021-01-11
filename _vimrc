"	======= Vundleの導入 ========
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 導入したいプラグインを以下に列挙
" Plugin '[Github Author]/[Github repo]' の形式で記入
Plugin 'airblade/vim-gitgutter'
Plugin 'justmao945/vim-clang'
Plugin 'lambdalisue/battery.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on
" =============================

colorscheme lucius

set number				" 行番号を表示する
set cursorline		" カーソルのある位置を強調表示する
set virtualedit=onemore		" カーソル移動を末尾の次の位置まで移動できるようにする
set smartindent 		" インデントを自動で調整してくれる
set shiftwidth=2	"	インデントを自動で合わせるときの空白数
set laststatus=2 "ステータスバーの常時表示

syntax on	" シンタックスハイライトを有効にする(enableでも設定はできるらしい)

set textwidth=0	"	インデント自動整形の時に勝手に折り返し改行をしないようにする
set tabstop=2 "tab入力した時のスペース入力数を変更する

set laststatus=2	"	画面下にステータスバーを表示する

set foldmethod=indent  "折りたたみ範囲の判断基準（デフォルト: manual）
set foldlevel=2        "ファイルを開いたときにデフォルトで折りたたむレベル
set foldcolumn=3       "左端に折りたたみ状態を表示する領域を追加する

let mapleader = "\<Space>" " スペースキーをショートカットのトリガーとして認識するように設定

" ==== ノーマルモードでのキーバインドの追加 ====
" Space + w (上書き保存)
nnoremap <Leader>w :w<CR> 
" Space + esc (vimを強制的に値を保存せずに抜ける)
nnoremap <Leader><Esc> :q!<CR>
" Space + wq (上書き保存してvimを抜ける)
nnoremap <Leader>x :wq<CR> 
" Shift + h (今カーソルがある行の末尾に移動する)
nnoremap <S-h> ^
" Shift + l (今カーソルがある行の先頭に移動する)
nnoremap <S-l> $

" ヤンクでコピーしたテキストをクリップボードに反映させる
set clipboard+=unnamed

"=========
"vim-clang
"=========
" 'shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clang
let g:clang_auto = 1
let g:clang_complete_auto = 0
let g:clang_auto_select = 1
let g:clang_use_library = 1
let g:clang_format_auto = 1
let g:clang_format_style = 'Google'
let g:clang_check_syntax_auto = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '
  \ -std=c++1z 
  \ -stdlib=libc++ 
  \ -pedantic-errors
  \ '

" }}}
"	下のバーの表示設定
let g:lightline = {
    \  'enable': { 'tabline': 0 },
    \  'colorscheme': 'wombat',
    \  'active': {
    \    'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified'] ],
    \    'right': [ ['battery'], ['fileencording'] ]
    \  },
    \  'component_function': {
    \    'battery': 'battery#component',
    \  }
    \}

let g:battery#update_tabline = 1    " For tabline.
let g:battery#update_statusline = 1 " For statusline.
