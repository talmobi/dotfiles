set nocompatible

" Pathogen here
call pathogen#helptags()
call pathogen#infect()

set hidden

set nowrap
set tabstop=2
set backspace=indent,eol,start

set autoindent
set copyindent
set number
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase

set smarttab

set hlsearch
set incsearch

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells

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
