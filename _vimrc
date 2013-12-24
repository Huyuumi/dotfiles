set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
 set matchpairs& matchpairs+=<:>

 " バックスペースでなんでも消せるようにする
 set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
 if has('unnamedplus')
     " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
         set clipboard& clipboard+=unnamedplus,unnamed 
         else
     " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
         set clipboard& clipboard+=unnamed
         endif

                 " Swapファイル？Backupファイル？前時代的すぎ
                 " なので全て無効化する
                 set nowritebackup
                 set nobackup
                 set noswapfile
" 検索関連
  set ignorecase          " 大文字小文字を区別しない
  set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
  set incsearch           " インクリメンタルサーチ
  set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
  cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
  cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" 表示関連
  set list                " 不可視文字の可視化
  set number              " 行番号の表示
  set wrap                " 長いテキストの折り返し
  set textwidth=0         " 自動的に改行が入るのを無効化
  set colorcolumn=80      " その代わり80文字目にラインを入れる
" 前時代的スクリーンベルを無効化
  set t_vb=
  set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
  set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" 入力モード中に素早くjjと入力した場合はESCとみなす
  inoremap jj <Esc>

"コンパイルキーマップ関連
":GCCでコンパイルする
command! GCC call s:GCC()
map! gcc :GCC<CR>
function! s:GCC()
	:w
	:!gcc % -o %.out
	:!./%.out
endfunction
":pyでコンパイルする
command! Python call s:Python()
map py :Python<CR>
function! s:Python()
	:w
	:!python %
endfunction

"Neobundle関連
set nocompatible
filetype off


if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
"  githubリポジトリ
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'

"入力補完プラグイン
NeoBundle 'mattn/emmet-vim' "HTML補完
NeoBundle 'tpope/vim-surround' "（）入力補完
NeoBundle 'YankRing.vim' "ヤンク入力補完

"カラースキーマ
NeoBundle 'croaker/mustang-vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
"python
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'troydm/easybuffer.vim'
filetype plugin indent on	"repuired!
filetype indent on

colorscheme jellybeans
set background=dark
"neocomplcacheの設定
NeoBundle 'Shougo/neocomplcache'
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" " Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" " Define dictionary.
 let g:neocomplcache_dictionary_filetype_lists = {
     \ 'default' : ''
         \ }

         " Plugin key-mappings.
         inoremap <expr><C-g>     neocomplcache#undo_completion()
         inoremap <expr><C-l>     neocomplcache#complete_common_string()

         " Recommended key-mappings.
         " <CR>: close popup and save indent.
         inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
         function! s:my_cr_function()
           return neocomplcache#smart_close_popup() . "\<CR>"
           endfunction
           " <TAB>: completion.
           inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
           " <C-h>, <BS>: close popup and delete backword char.
           inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
           inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
           inoremap <expr><C-y>  neocomplcache#close_popup()
           inoremap <expr><C-e>  neocomplcache#cancel_popup()
