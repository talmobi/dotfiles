set nocompatible

filetype on
filetype plugin on
filetype plugin indent on

" hidden buffers
set hidden

set synmaxcol=199 "syntax anti-choke!

" more color highlighting for *.json files
autocmd FileType json setlocal synmaxcol=299

" auto mark files based on type ( holy shit! )
" https://stackoverflow.com/a/16084326/3496140
augroup AutoGlobalMarkFilesBasedOnFileType
  autocmd!
  autocmd BufLeave *.css normal! mC
  autocmd BufLeave *.styl normal! mS
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.js normal! mJ
  autocmd BufLeave *.json normal! mO
  autocmd BufLeave *.php normal! mP
  autocmd BufLeave *.xml normal! mX
  autocmd BufLeave *NetrwTreeListing* normal! mT
augroup END

" auto save/load view
set viewoptions=cursor " only save cursor positions
augroup AutoFolds
  autocmd!
  autocmd BufWinLeave *.* silent mkview
  autocmd BufWinEnter *.* silent loadview
augroup END

" fold indents
set foldmethod=indent

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
  let fileNameLength = len(expand("%"))
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

command! ResetView :call ResetView()

" essentially adds flex support for vim-stylus plugin, see: https://github.com/wavded/vim-stylus/issues/46
hi def link stylusProperty cssVisualProp

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

set path=.,,

set wildmenu
set wildmode=list:full

" set wildignore=*/.*,.*

" Don't offer to open certain files/directories
set wildignore+=**/node_modules*
set wildignore+=**/.git*
set wildignore+=**/.svn*

" TODO revisit vim source files for recompiling
" with wildignore support for starstar **
" or perhaps hard coded skip of node_modules directory?
" see: https://github.com/vim/vim/issues/2132

set wildignore+=*.swp,*.swo,*~,*.swn,*.swm,*.bak,*.DS_Store

set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp
set wildignore+=*.psd
set wildignore+=*.mp4,*.avi,*.mpg,*.mpeg
set wildignore+=*.pyc,*.class

set wildignore+=tags
set wildignore+=*.tar.*
set wildignore+=*.zip

" open all folds recursively by default
nnoremap zo :call SaveScreenOpenFoldLoadScreen(0)<cr>
nnoremap zO :call SaveScreenOpenFoldLoadScreen(1)<cr>

nnoremap zc :set foldmethod=indent<cr>zc

function! SaveScreenOpenFoldLoadScreen (recursive)
  let w = winsaveview()

  if a:recursive > 0
    silent! normal! zO
  else
    silent! normal! zo
  endif

  silent! call winrestview(w)
endfunction

" bind some javascript syntax to same syntax groups
" hi def link javaScriptOperator JavaScriptMember
hi def link javaScriptOperator javaScriptIdentifier

" function! RefreshColorSchemes ()
"   execute ":colorscheme " . g:colors_name
" 
"   if &t_Co <= 8
"     " set basic colorscheme
"     colorscheme desert
" 
"     " darkblue hilight of cursor
"     hi CursorLine term=NONE cterm=NONE ctermbg=4
"   endif
" endfunction

function! TabMessage (cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" autocmd BufWinEnter * call RefreshColorSchemes()

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

" nnoremap t <c-]>

" 日本語のドット置いて。。。
nnoremap <a-o> A・<ESC>$
inoremap <a-o> ・

" instead bind it to q (and overwrite/disable default useless window quit short-cut)
" nnoremap <c-w>q <c-w>c

" shortcut to full size splitted window ( use <c-w>= to equalize )
nnoremap <c-w>z <c-w>_ <c-w>\|

" open ( file / buffer ) in splits
cnoremap <c-t> \| tab split<cr>gT:b#<cr>gt
cnoremap <c-x> \| split<cr><c-w><c-p>:b#<cr><c-w><c-p>
cnoremap <c-v> \| vsplit<cr><c-w><c-p>:b#<cr><c-w><c-p>

noremap <c-w><c-u> <c-w><c-p>

" nnoremap <c-p> :e *<c-i>**/

" cheap, non-fuzzy, built-in CtrlP
" nnoremap <c-p> :call feedkeys(":e \<tab>**/", 't')<cr>
nnoremap <c-p> :e <c-d>*
cnoremap <c-o> */*<c-d>

" don't prompt listings
set nomore

" buffer shotcut
nnoremap <c-l> :ls<cr>:b<space>

" nmap <a-l> <Plug>Colorizer

" disable at startup ( use manually only )
let g:colorizer_startup = 0

" max lines
let g:colorizer_maxlines = 300

" paste replace without yanking replaced text
vnoremap p "_dP
vnoremap P "_dP

function! VisualSearch ()
  " remember values of the registers we are temporarily mutating
  let temp = getreg("\"")
  let tempv = getreg("v")

  " set last visual selection to register v
  normal! gv"vy
  let raw_search = getreg("v")
  " escape the text for searching
  let search = escape(raw_search, '\/.*$^~[]"')

  " restore the previous values of the registers we mutated
  call setreg("v", tempv)
  call setreg("\"", temp)

  let s = "/" . search . "\<cr>" . "\<c-o>"
  call feedkeys( s )
endfunction

function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

nnoremap ss :call ResetView()<cr>:source ~/.vimrc<cr>

" vnoremap // "ay/<c-r>a<cr>:call RestorePreviousYank()<cr>N
" vnoremap // :call VisualSearch()<cr>/<c-r>a<cr>N
vnoremap // :call VisualSearch()<cr>

vnoremap Y ygv:call VisualSearch()<cr>

" better default * ( doesn't move cursor at start)
nnoremap * *<c-o>
vnoremap * <esc>:call VisualSearch()<cr>
" have # as alias to * ( instead of default reverse search )
nnoremap # *<c-o>
vnoremap # <esc>:call VisualSearch()<cr>
" vmap # *cgn
" vnoremap # <esc>:call VisualSearch()<cr>cgn
" vnoremap # :call VisualSearch()<cr>*''cgn


" type in the <CR> implicitly for you
nnoremap // 0//<cr>

" Pathogen here
" execute pathogen#helptags()
" execute pathogen#infect()

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'tomtom/tcomment_vim'

Plug 'vim-scripts/gitignore'

" Plug 'skammer/vim-css-color'
" Plug 'ap/vim-css-color'

" slow...
" Plug 'lilydjwg/colorizer'

Plug 'hail2u/vim-css3-syntax'

Plug 'wavded/vim-stylus'

Plug 'rstacruz/sparkup'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'junegunn/seoul256.vim'

call plug#end()

" Mapping selecting mappings
" nnoremap <c-p> :GFiles<cr>
" nnoremap <c-f> :Files<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" let g:colorizer_auto_filetype='css,html,styl'

" make sure cursorline is always visible
set cursorline
au VimEnter,WinEnter,BufWinEnter * setlocal cursorline

" CtrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_md = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" ignore silly files and directores from CtrlP search
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" dont set sparkup mappings by default
let g:sparkupNextMapping = '<nop>'

" set sparkup mappings for html files
" autocmd FileType html let g:sparkupMaps=1

" config netrw a bit
autocmd FileType netrw setlocal bufhidden=wipe
let g:netrw_list_hide= '.*\.swp$'
let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'

" load dictionaries basedon filetype
autocmd FileType javascript setlocal dictionary+=~/.vim/words/Element.props.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/Element.methods.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/HTMLElement.props.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/HTMLElement.methods.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/EventTarget.methods.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/Node.props.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/Node.methods.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/HTMLCanvasElement.props.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/HTMLCanvasElement.methods.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/CanvasRenderingContext2D.props.txt
autocmd FileType javascript setlocal dictionary+=~/.vim/words/CanvasRenderingContext2D.methods.txt

" add some general words to default dict
set complete+=k~/.vim/words/global.txt

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

set completeopt-=noinsert
set completeopt+=menuone
set completeopt+=preview

" LINT

" use spacestandard linter by default ( for vim's built in quickfix )
" (:make, :copen, :cn, :cp, etc)
set makeprg=spacestandard\ %
let g:defaultmakeprg=&makeprg

" use 'npm run lint' as is common in javascript nodejs projects as default
autocmd FileType javascript setlocal makeprg=npm\ run\ lint\ --silent

" run a shell command and grab its output into vim's quickfix
" ( by temporarily setting makeprg and calling make, and then
" restoring the makeprg optionback to what it was )
function! ShellCommandToQuickfix (command)
  " clear the screen
  silent !clear

  " remeber the makeprg
  let prg=&makeprg

  " set the makeprg temporarily so that we can grab the output
  " of the command into quickfix
  let cmd='set makeprg=' . escape( a:command, "/\"'$] " )
  execute cmd

  " run the command with make
  make

  " reset the makeprg back to what it was originally
  let &makeprg=prg
endfunction

" bind ShellCommandToQuickfix to a readible command
command! -nargs=+ -complete=shellcmd Q call ShellCommandToQuickfix(<q-args>)

" a few common npm scripts to run
command! Lint :call ShellCommandToQuickfix("npm run lint")
command! Fixlint :call ShellCommandToQuickfix("npm run fixlint")

" use some other default makeprg based on filetype
" autocmd Filetype foo setlocal makeprg=/bin/foo


" holy fucking shit!!!!!
" set grepprg=rg\ --vimgrep
" set grepprg=grep\ --ignore-case\ --fixed-strings
" set grepprg=grep\ --color\ -iF

" useful grep
" set grepprg=grep\ -rn
set grepprg=grep\ --exclude=*node_modules*\ --exclude=*.git/*\ -rn

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

if &t_Co <= 16
  " set basic colorscheme
  colorscheme desert

  " darkblue hilight of cursor
  hi CursorLine term=NONE cterm=NONE ctermbg=4
endif

" syn debugging helper
" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" SNIPPETS

" sample package json snippet
nnoremap snipp :let @x=''<CR>m'"xciW<ESC>:-1read $HOME/.vim/snippets/package.json<CR>V'':s/NAME/<C-R>x/g<CR>/TODO<CR>

" sample html5 snippet
nnoremap sniph :let @x=''<CR>m'"xciW<ESC>:-1read $HOME/.vim/snippets/index.html<CR>/TODO<CR>''4jcit<ESC>"xpa

" sample rollup.config.js snippet
nnoremap snipr :-1read $HOME/.vim/snippets/index.html<CR>

" Generic highlighting
" https://github.com/j16180339887/Global.vim/blob/master/plugin/Global.vim
autocmd BufRead,BufNewFile,BufWritePost * call HighlightGlobal()
function! HighlightGlobal()
  if &filetype == "" || &filetype == "text"
    syn match alphanumeric  "[A-Za-z0-9_]"
    " Copy from $VIM/syntax/lua.vim
    " integer number
    syn match txtNumber     "\<\d\+\>"
    " floating point number, with dot, optional exponent
    syn match txtNumber     "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, starting with a dot, optional exponent
    syn match txtNumber     "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
    " floating point number, without dot, with exponent
    syn match txtNumber     "\<\d\+[eE][-+]\=\d\+\>"
    " Wide characters and non-ascii characters
    syn match nonalphabet   "[\u0021-\u002F]"
    syn match nonalphabet   "[\u003A-\u0040]"
    syn match nonalphabet   "[\u005B-\u0060]"
    syn match nonalphabet   "[\u007B-\u007E]"
    syn match nonalphabet   "[^\u0000-\u007F]"
    syn match lineURL       /\(https\?\|ftps\?\|git\|ssh\):\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
    hi def link alphanumeric  Function
    hi def link txtNumber      Define
    hi def link lineURL        Number
    hi def link nonalphabet   Conditional
  endif
endfunction
