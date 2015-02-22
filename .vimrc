syntax on
set number
set autoindent
set background=dark
colorscheme desert
set wildmode=list:longest,list:full
set complete=.,w,t

set splitbelow
set splitright

set t_Co=256

hi CursorLineNr guifg=#050505
set cursorline
set nocompatible
set showcmd
set ruler
set laststatus=2

set encoding=utf-8
set smartcase
set ignorecase

set list listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<

set tabstop=2
set shiftwidth=2
set expandtab

imap jk <Esc>


let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

execute pathogen#infect()
syntax on
filetype plugin indent on

let g:hybrid_use_Xresources = 1
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
