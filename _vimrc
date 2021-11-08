"	======= Vundle ========
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 導入したいプラグインを以下に列挙
" Plugin '[Github Author]/[Github repo]' の形式で記入
Plugin 'itchyny/lightline.vim'        " statuslineをおしゃれにする
Plugin 'lambdalisue/battery.vim'      " バッテー表示をlightline.vimに表示させる
Plugin 'scrooloose/nerdtree'          " ファイルツリーを表示する
Plugin 'simeji/winresizer'            " リサイズをCtrl + Eでhjklで操作できるようになる
Plugin 'open-browser.vim'             " ブラウザ検索を楽にする
Plugin 'previm/previm'                " マークダウンをブラウザでリアルタイムプレビュー
Plugin 'tpope/vim-surround'           " かっこやダブルクオートを便利にする
Plugin 'ryanoasis/vim-devicons'       " NERDTreeにアイコンを表示
"==== HTML関係 ====
Plugin 'mattn/emmet-vim'              " HTMLのタグの入力を楽にする(Ctrl+k -> y)
Plugin 'hail2u/vim-css3-syntax'       " cssのシンタックス
" === 言語サーバー ===
Plugin 'neoclide/coc.nvim',{'do': {-> coc#util#install()}}

" === 言語パック ===
Plugin 'sheerun/vim-polyglot'

Plugin 'w0rp/ale'
Plugin 'tokorom/vim-swift-format'

" === C/C++の実行 ===
Plugin 'xuhdev/SingleCompile'

" === Vimのプレビューをターミナルで表示する ===
Plugin 'skanehira/preview-markdown.vim'

call vundle#end()
filetype plugin indent on
" =============================

" ===== カラースキームの設定 ====
colorscheme gruvbox
set bg=dark
" ===============================

" ==== vim標準の設定 ====
syntax on                       " シンタックスハイライトを有効にする(enableでも設定はできるらしい)
set encoding=utf-8              " 文字コードの設定
set number                      " 行番号を表示する
set cursorline                  " 選択行をハイライト
set backspace=indent,eol,start  " バックスペースの有効化
set wrap                        " 長い行を折り返す
set noswapfile                  " スワップファイルを生成しない
set virtualedit=onemore         " カーソル移動を末尾の次の位置まで移動できるようにする
set smartindent                 " インデントを自動で調整してくれる
set shiftwidth=2                " インデントを自動で合わせるときの空白数
set laststatus=2                " ステータスバーを常時表示
set textwidth=0                 " インデント自動整形の時に勝手に折り返し改行をしないようにする
set tabstop=2                   " tab入力した時のスペース入力数を変更する
set expandtab                   " タブをスペースに置き換える
set mouse=a                     " マウスを使えるようにする
set scrolloff=3                 " 画面スクロールを端から3行目で行うように変更
set clipboard+=unnamed          " ヤンクでコピーしたテキストをクリップボードに反映させる

" ---- スペース、タブ、改行の可視化 ----
set list
set listchars=tab:»»,space:-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" ---- 補完の挙動を変更 ----
" 候補が１つしかないときもポップアップメニューを表示,自動で挿入しない、選択項目のプレビューを表示する
set completeopt=menuone,noinsert,preview
" Enter入力時に改行を行わないようにする
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>" 
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" >>>> キーマップ変更 <<<<
let mapleader = "\<Space>" " スペースキーをショートカットのトリガーとして認識するように設定
" >>>> ノーマルモード <<<<
" ---- 論理行移動から表示行移動に変更 ----
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" ----------------------------------------
" Space + w (上書き保存)
nnoremap <Leader>w :w<CR> 
" Space + esc (vimを強制的に値を保存せずに抜ける)
nnoremap <Leader><Esc> :q!<CR>
" Space + wq (上書き保存してvimを抜ける)
nnoremap <Leader>x :wq<CR> 
" ファイルを開いてフォーカスを戻す
nnoremap <Leader>o :ChromeOpen<CR>
" Space + hjkl(バッファ移動)
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
" Ctrl + l (.vimrcの再読み込み)
nnoremap <C-l> :source ~/.vimrc<CR>
" Shift + h (今カーソルがある行の末尾に移動する)
nnoremap <S-h> ^
" Shift + l (今カーソルがある行の先頭に移動する)
nnoremap <S-l> $
" 消去コマンドでヤンクするのを防ぐ
nnoremap d "_d
nnoremap D "_D
nnoremap x "_x
xnoremap d "_d
xnoremap p "_dP

" >>>> ヴィジュアルモード <<<<
" Shift + h (行始まで選択)
vnoremap <S-h> ^
" Shift + l (行端まで選択)
vnoremap <S-l> $

" >>>> インサートモード <<<<
"	Ctrl + c (Escapeキーと同じ挙動にする)
imap <C-c> <Esc>
imap jj <Esc>

" ==== プラグイン設定 ====
" ---- preview-markdown.vim ----
let g:preview_markdown_vertical = 1   " 縦に分割
let g:preview_markdown_auto_update = 1  " マークダウン保存時プレビューの自動更新
set splitright  " 右側に表示

" ---- NERDTree ----
nnoremap <silent><C-n> :NERDTreeToggle<CR>

" ---- vim-fugitive ----
nnoremap <silent><C-g> :Gstatus<CR>

" ---- open-browser.vim ----
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ---- vim-devicons ----
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" ---- lightline.vim ----
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

" ---- battery.vim ----
let g:battery#update_tabline = 1    " For tabline.
let g:battery#update_statusline = 1 " For statusline.

" ---- coc.vim ----
set hidden            " ファイルを保存していなくても閉じられる
set nobackup          " バックアップファイルを作成しない
set nowritebackup     " バックアップファイルを上書きしない
set shortmess+=c      " 補完時の該当件数の表示をしない
" signcolumn(画面一番下の部分)を常時表示する
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " 新しいバージョンだとsigncolumnとnumbercolumnを１つの行で表示できるので、１つの行で表示するようにする
  set signcolumn=number
else
  set signcolumn=yes
endif

" coc-htmlでLaravelのbladeとpythonのjangoの補完を使えるようにする
let g:coc_filetype_map = {
  \ 'blade': 'html',
  \ 'htmldjango': 'html',
  \ }

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ctrl + spaceで補完ウィンドウを閉じる
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Enterで候補欄最初の行の文字を挿入する
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" エラーのある箇所にカーソルを移動する
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" コードナビゲーションへ移動
" 定義へ移動
nmap <silent> gd <Plug>(coc-definition)
" 型の定義へ移動(使えないときが多い？）
nmap <silent> gy <Plug>(coc-type-definition)
" 実装へ移動
nmap <silent> gi <Plug>(coc-implementation)
" リファレンスを表示(vimgrepとcw使ってそう)
nmap <silent> gr <Plug>(coc-references)

" カーソルの乗っているコードのドキュメント(定義の概要)を表示するgdの概要版
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" カーソルの乗っているコードと同じ部分をハイライトする
autocmd CursorHold * silent call CocActionAsync('highlight')

" リネーム
nmap <leader>rn <Plug>(coc-rename)

" Space + f : 整形
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" === vim-polyglot ===
"let g:polyglot_disabled = ['markdown.plugin']
let g:vim_markdown_new_list_item_indent = 2

" === swift-format ===
let g:ale_linters = {
\   'swift': ['swift-format'],
\}

let g:vim_swift_format_use_ale = 1
