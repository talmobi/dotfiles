set nocompatible

set hidden

set nowrap
set tabstop=2
set backspace=indent,eol,start

set scrolloff=6
set sidescrolloff=7
set sidescroll=1

set cindent
set cino=b1,+0,p0,(s,m1,t0 "sane indentations (see :help cino)

set autoindent
set copyindent
set number
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase
set encoding=utf-8

set smarttab
set expandtab

set splitbelow
set splitright

set ruler

set hlsearch
set incsearch

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells

set wildmode=list:longest ",list:full
set wildmenu
set wildignore=*.swp,*.swo,*~,*.swn,*.swm,*.bak,*.pyc,*.class

filetype plugin indent on

set background=dark

if &t_Co >= 256 || has("gui_running")
  colorscheme gruvbox
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

set list
set listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<,nbsp:¶

set pastetoggle=<F2>
set showmode

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

cmap w!! w !sudo tee % >/dev/null

nmap <silent> ,, :nohlsearch<CR>

" Pathogen here
execute pathogen#helptags()
execute pathogen#infect()

"
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" make sure cursorline is alwasy visible
set cursorline
au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
" au BufWinEnter *.* set cursorline

" CtrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_md = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" neocomplete plugin
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" statusline setup
set statusline=[%{pathshorten(getcwd())}] "display shortened path of current directory
set statusline+=\ %t       "tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


" set wildmode=list:longest,list:full
" set complete=.,w,t
" 
" set splitbelow
" set splitright
" 
" set t_Co=256
" 
" let g:hybrid_use_Xresources = 1
" let g:hybrid_use_iTerm_colors = 1
" colorscheme gruvbox
" 
" " hi CursorLineNr guifg=#050505
" set cursorline
" set nocompatible
" set showcmd
" set ruler
" set laststatus=2
" 
" set encoding=utf-8
" set smartcase
" set ignorecase
" 
" set list listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<,nbsp:¶
" 
" set autoindent
" set tabstop=2
" set shiftwidth=2
" set expandtab
" 
" set scrolloff=6
" 
" " let g:neocomplete#enable_at_startup = 1
" " let g:neocomplete#enable_smart_case = 1
" " let g:neocomplete#sources#syntax#min_keyword_length = 3
" " inoremap <expr><C-g>  neocomplete#undo_completion()
" " inoremap <expr><C-l>  neocomplete#complete_common_string()
" " " <TAB>: completion.
" " inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" 
" " Enable syntax omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" 
" " prefer longest first
" set completeopt+=longest
" 
" syntax on
" filetype plugin indent on
" " filetype indent off
" 
" " autocmd FileType javascript set formatoptions=t
" " set formatoptions=2,l
" 
" set pastetoggle=<F2>
" set showmode
" 
" au BufWinLeave *.* mkview
" au BufWinEnter *.* silent loadview
