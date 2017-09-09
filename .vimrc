set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

" hidden buffers
set hidden

set synmaxcol=199 "syntax anti-choke!

" more color highlighting for *.json files
autocmd FileType json setlocal synmaxcol=299
" autocmd BufNewFile,BufRead *.json setlocal synmaxcol=299

" auto save/load folds etc
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
augroup END

" dev testing function
" function! NameLength ()
"   let s = len( expand( "%" ) )
"   echo s
" 
"   let limit = 14
" 
"   if s > limit
"     echo 'bigger than limit'
"   else
"     echo 'less than limit'
"   endif
" endfunction

" sometimes mk/loadview fucks up, so here
" is a function to reset the view file
" ( found in ~/.vim/view/ ) of the current file
function! ResetView ()
  " make sure the filename is of reasonable length
  let fileNameLength = len( expand( "%" ) )
  if fileNameLength > 2
    " where to find the view files
    let dir = "~/.vim/view/*"

    " build the command we want to execute
    " list the files with find
    " parse the results with grep
    " pipe through xargs and delete with dm
    let cmd = "!" . "find " . dir . " | grep % | xargs rm"

    " ripgrep version ( not necessary probably )
    " let cmd = "!" . "rg --files -g " . dir . " | rg % | xargs rm"

    " clear output
    silent !clear

    " run in silent mode
    execute "silent " . cmd
    " echo "silent " . cmd

    " redraw screen ( otherwise it may be all black )
    redraw!
  else
    echo "file name was too short ( less than 3 ), did not delete viewfile"
  endif
endfunction

" essentially adds flex support for vim-stylus plugin, see: https://github.com/wavded/vim-stylus/issues/46
hi link stylusProperty cssVisualProp

set nowrap
set tabstop=2
set backspace=indent,eol,start

set scrolloff=6
set sidescrolloff=5 " was 7
set sidescroll=4 " was 5

set cindent
set cino=b1,+0,p0,(s,m1,t0 "sane indentations (see :help cino)
" set cinw-=if,else,while, "disable word indentation
set cinw='' "disable all word indentation (enable this for python)

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
set wildignore=*.swp,*.swo,*~,*.swn,*.swm,*.bak,*.pyc,*.class,*node_modules*,*.git,*.DS_Store

" open all folds recursively by default
nnoremap zo zCzO
nnoremap zO zo

" fold indents
set foldmethod=indent

" bind some javascript syntax to same syntax groups
" hi def link javaScriptOperator JavaScriptMember
hi def link javaScriptOperator javaScriptIdentifier

set background=dark


" gruvbox contrasts ( medium on all by default )
" let g:gruvbox_contrast_light='soft'
" let g:gruvbox_contrast_light='medium'
" let g:gruvbox_contrast_light='hard'

" let g:gruvbox_contrast='soft'
" let g:gruvbox_contrast='medium'
" let g:gruvbox_contrast='hard'

" let g:gruvbox_contrast_dark='soft'
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_contrast_dark='hard'


if &t_Co >= 256 || has("gui_running")
  " Fixes background color erase
  " see: https://sunaku.github.io/vim-256color-bce.html
  set t_ut=
  colorscheme gruvbox
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

if &t_Co <= 8
  " set basic colorscheme
  colorscheme desert

  " darkblue hilight of cursor
  hi CursorLine ctermbg=4
endif

set list
set listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<,nbsp:¶

set pastetoggle=<F2>
set showmode

" Use Q for formatting the current paragraph (or selection)
" vmap Q gq
" nmap Q gqap

" sudo write shorthand
cmap w!! w !sudo tee % >/dev/null

nmap <silent> ,, :nohlsearch<CR>

" disable default useless and annoying ctrl-w_c ( use :close or :q instead )
noremap <c-w>c <nop>
noremap <c-w>q <nop>
" disable another default useless and annoying ctrl-w_o ( use :only instead )
noremap <c-w>o <nop>
" nnoremap <c-w><c-c> <nop>

nnoremap t <c-]>

" cgn based replace
nnoremap # *''cgn

" better default * ( doesn't move cursor at start)
nnoremap * *''0n

" instead bind it to q (and overwrite/disable default useless window quit short-cut)
" nnoremap <c-w>q <c-w>c

" shortcut to full size splitted window (use <c-w>= to equalize)
nnoremap <c-w>z <c-w>_ <c-w>\|

" paste replace without yanking replaced text
vnoremap p "_dP
" vnoremap // "9y/<c-r>9<cr>
" vnoremap // "_d"-P/<c-r>-<cr>N

" let g:_unnamedReg = @"
" function! StoreUnnamedReg ()
"   let g:_unnamedReg = @"
" endfunction
" 
" function! LoadUnnamedReg ()
"   let @" = g:_unnamedReg
" endfunction
" 
" vnoremap // :call StoreUnnamedReg()<cr>"ay/<c-r>a<cr>N:call LoadUnnamedReg()<cr>

" function! RestorePreviousYank ()
"   let @" = @0
" endfunction

function! VisualSearch ()
  let temp = @"
  normal! gv"ay
  let search = escape( @a, "/\"'$]" )
  let @a = search
  let @" = temp

  let s = "/" . search . "\<cr>" . "N"
  call feedkeys( s )
endfunction

nnoremap ss :call ResetView()<cr>:source ~/.vimrc<cr>

" vnoremap // "ay/<c-r>a<cr>:call RestorePreviousYank()<cr>N
" vnoremap // :call VisualSearch()<cr>/<c-r>a<cr>N
vnoremap // :call VisualSearch()<cr>

vnoremap * :call VisualSearch()<cr>

vnoremap Y ygv:call VisualSearch()<cr>

" type in the <CR> implicitly for you
nnoremap // 0//<cr>

" nnoremap <C-W>

"
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Pathogen here
execute pathogen#helptags()
execute pathogen#infect()

" make sure cursorline is alwasy visible
set cursorline
au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
" au BufWinEnter *.* set cursorline

" suppress ctags version warning (since universal-ctags)
" let g:easytags_suppress_ctags_warning = 1

" multi cursor plugin https://github.com/terryma/vim-multiple-cursors
" let g:multi_cursor_use_default_mapping = 0 " turn off default keybinds

" CtrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_md = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" ignore silly files and directores from CtrlP search
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" set includeexpr=substitute(v:fname,'\\.',expand('%:p:h'),'')

" dont set sparkup mappings by default
let g:sparkupNextMapping = '<nop>'

" set sparkup mappings for html files
" autocmd FileType html let g:sparkupMaps=1

" neocomplete plugin
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#sources#syntax#max_keyword_length = 30
" let g:neocomplete#sources#buffer#max_keyword_length = 30

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

" load all help files
silent! helptags ALL

" show commands as they are being typed in
set showcmd

" disable command timeouts ( fixes buggy <c-w> [timeout] c issues )
set notimeout

" disable tiny preview window on omnicomplete
" set completeopt-=preview


" LINT

" use spacestandard linter by default ( for vim's built in quickfix )
" (:make, :copen, :cn, :cp, etc)
set makeprg=spacestandard\ %

" use some other default makeprg based on filetype
" autocmd Filetype foo setlocal makeprg=/bin/foo


" holy fucking shit!!!!!
set grepprg=rg\ --vimgrep


" SNIPPETS

" sample package json snippet
nnoremap snipp :let @x=''<CR>m'"xciW<ESC>:-1read $HOME/.vim/snippets/package.json<CR>V'':s/NAME/<C-R>x/g<CR>/TODO<CR>

" sample html5 snippet
nnoremap sniph :let @x=''<CR>m'"xciW<ESC>:-1read $HOME/.vim/snippets/index.html<CR>/TODO<CR>''4jcit<ESC>"xpa

" sample rollup.config.js snippet
nnoremap snipr :-1read $HOME/.vim/snippets/index.html<CR>
