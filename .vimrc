set nocompatible

filetype on
filetype plugin on
filetype indent off

" hidden buffers
set hidden

set synmaxcol=199 "syntax anti-choke!

" more color highlighting for *.json files
autocmd FileType json setlocal synmaxcol=299

" set swap file directory
" ref: https://vi.stackexchange.com/questions/177/what-is-the-purpose-of-swap-files
" The ^= syntax for :set prepends the directory name to the head of the list, so Vim will check that directory first.
" The // at the end of the directory name tells Vim to use the absolute path to the file to create the swap file so there aren't collisions between files of the same name from different directories.
set directory^=$HOME/.vim/swaps//

" suffixes to check when using 'gf' ( mnemnomic goto file )
set suffixesadd+=.js,.jsx,.json,.java,.py

" auto mark files based on type ( holy shit! )
" https://stackoverflow.com/a/16084326/3496140
" augroup AutoGlobalMarkFilesBasedOnFileType
"   autocmd!
"   autocmd BufLeave *.css normal! mC
"   autocmd BufLeave *.styl normal! mS
"   autocmd BufLeave *.html normal! mH
"   autocmd BufLeave *.js normal! mJ
"   autocmd BufLeave *.json normal! mO
"   autocmd BufLeave *.php normal! mP
"   autocmd BufLeave *.xml normal! mX
"   autocmd BufLeave *NetrwTreeListing* normal! mT
" augroup END

" fold indents
set foldmethod=indent

" format options
set formatoptions=tcq "vim default
set formatoptions=croql "mollie-1.local default
set formatoptions= "current, disabled TODO

" set preferred textwidth for gq etc ( :help textwidth )
" -> this way when organizing long text with gq ( such as
"  comments and, incidentally this very comment, it will not
"  wrap or be too long in most situations.
set textwidth=80

" auto save/load view
set viewoptions=cursor " only save cursor positions
augroup AutoFolds
  autocmd!
  autocmd BufWinLeave *.* silent mkview
  autocmd BufWinEnter *.* silent loadview
augroup END


set path=.,,

if !exists("g:init_path")
  let g:init_path = expand( "%:p:h" )
  let &path = &path . ',' . expand( "%:p:h" )
  call setreg( "P", g:init_path )
endif

" cheap, non-fuzzy, built-in CtrlP
nnoremap <c-p> :call feedkeys(":e " . g:init_path . "/" . "\<c-d>" ."*")<cr>

" quick arga and args ( pretty rarely used, maybe not necessary.. )
" nnoremap <c-a> :call feedkeys(":arga " . g:init_path . "/" . "\<c-d>" ."*")<cr>
" nnoremap <c-s> :call feedkeys(":args " . g:init_path . "/" . "\<c-d>" ."*")<cr>

" don't prompt listings
set nomore

" buffer shotcut
nnoremap <c-l> :ls<cr>:b<space>

" jump to outermost function call line
" use '' or ctrl-O manually to jump back to previous position
nnoremap 4<c-g> m':?^\(await\)\=\w\+\s*?<cr>:call histdel('search', -1)<cr>:nohlsearch<cr>:call FlashCursor()<cr>

" jump to outermost keyword (function) line (name) (ty romainl)
" use '' or ctrl-O manually to jump back to previous position
nnoremap 3<c-g> m':?^\(function\\|async.function\).\w?<cr>:call histdel('search', -1)<cr>:nohlsearch<cr>:call FlashCursor()<cr>

" jump to nearest top function
nnoremap 2<c-g> m':?\(function\\|async.function\).\w?<cr>:call histdel('search', -1)<cr>:nohlsearch<cr>:call FlashCursor()<cr>

if executable('fzf')
  " fzf fuzzy CtrlP
  nnoremap <c-f> :execute ":Files " . g:init_path<cr>
  nnoremap  :execute ":Buffers"<cr>
endif

nnoremap <c-k> :e <c-d>*
cnoremap <c-o> */*<c-d>

autocmd BufEnter * silent! cd %:h
" set autochdir

" cheap, non-fuzzy, built-in CtrlP
" nnoremap <c-f> :call feedkeys(":Files " . g:init_path . "/")<cr>
" nnoremap <c-p> :call feedkeys(":e \<tab>**/", 't')<cr>
" nnoremap <c-p> :e g:init_path*
" nnoremap <c-p> :e <c-d>*

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

" break long lines visually into more lines
" set nowrap
set wrap

set scrolloff=6
set sidescrolloff=5 " was 7
set sidescroll=4 " was 5

set cino=b1,+0,p0,m1 "sane indentations (see :help cino)
set cinw-=if,else,while, "disable word indentation

set cino=''

set cinw='' "disable all word indentation (enable this for python)
set cinw=({

set nocindent
set noautoindent
set nocopyindent
set nosmartindent

set cindent

" set isk+=- " consider words as part of -

set number " show column number on left side

set showmatch
set ignorecase
set smartcase
set encoding=utf-8
"set ++enc=utf-8 " override fileencoding to utf-8

set shiftround

set nosmarttab
set noexpandtab

set shiftwidth=0 " spaces used when indenting and shifting <<, >> if 0 used tabs
set tabstop=4 " how many spaces a tab should look like
set backspace=indent,eol,start

set splitbelow
set splitright

set ruler

set hlsearch
set incsearch

set history=1000
set undolevels=1000

set title

set visualbell
set t_vb=

set noerrorbells

set wildmenu
set wildmode=list:full

" set wildignore=*/.*,.*

" Don't offer to open certain files/directories
" set wildignore+=**/node_modules*
" when using vimgrep consider :vimgrep /foo/ `git ls-files` to
" skip gitignored files/dirs like node_modules
set wildignore+=**/.git*
set wildignore+=**/.svn*

" ignore bundle files
" set wildignore+=*bundle.*

" ignore minified files
" set wildignore+=*.min.*

" TODO revisit vim source files for recompiling
" with wildignore support for starstar **
" or perhaps hard coded skip of node_modules directory?
" see: https://github.com/vim/vim/issues/2132

set wildignore+=*.swp,*.swo,*~,*.swn,*.swm,*.bak,*.DS_Store

" set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp
set wildignore+=*.psd
set wildignore+=*.mp4,*.avi,*.mpg,*.mpeg
set wildignore+=*.pyc,*.class

set wildignore+=tags
" set wildignore+=*.tar.*
" set wildignore+=*.zip

" open all folds recursively by default
nnoremap zo :call SaveScreenOpenFoldLoadScreen(0)<cr>
nnoremap zO :call SaveScreenOpenFoldLoadScreen(1)<cr>

nnoremap zc :set foldmethod=indent<cr>zc

function! Utf8 ()
  :e ++enc=utf-8 " override fileencoding to utf-8
endfunction
command! -complete=command Utf8 call Utf8()

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

" http://vim.wikia.com/wiki/Append_output_of_an_external_command
" :command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" autocmd BufWinEnter * call RefreshColorSchemes()

set list
set listchars=tab:»·,trail:·,eol:¬,extends:>,precedes:<,nbsp:¶

set pastetoggle=<F2>
set showmode

" sudo write shorthand
cmap w!! w !sudo tee % >/dev/null

nmap <silent> ,, :nohlsearch<CR>:call FlashCursor()<CR>

" disable default useless and annoying ctrl-w_c ( use :close or :q instead )
noremap <c-w>c <nop>
noremap <c-w>q <nop>
" disable another default useless and annoying ctrl-w_o ( use :only instead )
noremap <c-w>o <nop>

" disable default useless visaul lowercase/uppercase transform
xnoremap u <nop>
xnoremap U <nop>
xnoremap gu <nop>
xnoremap gU <nop>
nnoremap gu <nop>
nnoremap gU <nop>

" 日本語のドット置いて。。。 japanese dot
nnoremap <a-o> A・<ESC>$
inoremap <a-o> ・
nnoremap œ A・<ESC>$
inoremap œ ・

" celsius
inoremap <a-c> °C
inoremap ç °C

" fahtenheit
inoremap <a-f> °F
inoremap ƒ °F

" temperature ball
inoremap <a-g> °
inoremap ¸ °

" inifnity symbol
inoremap <a-i> ∞
inoremap ı ∞

" instead bind it to q (and overwrite/disable default useless window quit short-cut)
" nnoremap <c-w>q <c-w>c

" shortcut to full size splitted window ( use <c-w>= to equalize )
nnoremap <c-w>z <c-w>_ <c-w>\|

" open ( file / buffer ) in splits
cnoremap <c-t> \| tab split<cr>gT:b#<cr>gt
cnoremap <c-x> \| split<cr><c-w><c-p>:b#<cr><c-w><c-p>
cnoremap <c-v> \| vsplit<cr><c-w><c-p>:b#<cr><c-w><c-p>

" nnoremap <c-p> :e *<c-i>**/
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

nnoremap ss :call ResetView()<cr>:syntax off<cr>:source ~/.vimrc<cr>

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

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-journal'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'

" indent text object
" github.com/michaeljsmith/vim-indent-object
" ai, ii, aI, iI
Plug 'michaeljsmith/vim-indent-object'

" https://github.com/tpope/vim-surround
" cs"', ds"
Plug 'tpope/vim-surround'

" https://github.com/tpope/vim-commentary
" gcc, gcip, 4gc
Plug 'tpope/vim-commentary'

" graphql filetype detectio and syntax highlighting
Plug 'jparise/vim-graphql'

" Plug 'tomtom/tcomment_vim'

Plug 'vim-scripts/gitignore'

" for :Reject, :Keep and :Restore in quickfix list -- it's amazing
" ( instead of set modifiable and :v/snip/d etc that breaks the jump marks... )
Plug 'romainl/vim-qf'

" typescript syntax highlighting
Plug 'leafgarland/typescript-vim'

" Plug 'skammer/vim-css-color'
" Plug 'ap/vim-css-color'

" slow...
" Plug 'lilydjwg/colorizer'

Plug 'hail2u/vim-css3-syntax'

Plug 'wavded/vim-stylus'

" Plug 'jbgutierrez/vim-better-comments'

" Plug 'jelera/vim-javascript-syntax'
" Plug 'pangloss/vim-javascript'
" Plug 'Quramy/vim-js-pretty-template'

" let g:javascript_plugin_jsdoc = 0
" let g:javascript_plugin_ngdoc = 0
" let g:javascript_plugin_flow = 0
" set conceallevel=0

" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'

" Plug 'junegunn/seoul256.vim
" Plug 'junegunn/limelight.vim'
" Plug 'junegunn/goyo.vim'

" spark for html5 shorthands
" e.g. html:5<c-e> auto complates to a html template
" e.g. div#root<c-r> completes to <div id="root"></div> and sets cursor position inside the div
Plug 'rstacruz/sparkup'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" https://github.com/prabirshrestha/vim-lsp
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

" https://github.com/natebosch/vim-lsc
" Plug 'natebosch/vim-lsc'

call plug#end()

" remove '-' from iskeyword if it is set by css plugins
" ( set by vim-stylus plugin at the moment )
set iskeyword-=-

" Mapping selecting mappings
" nnoremap <c-p> :GFiles<cr>
" nnoremap <c-f> :Files<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" let g:colorizer_auto_filetype='css,html,styl'

" flash the cursorline
function! FlashCursor()
  set cursorline
  redraw
  sleep 175m
  set nocursorline
endfunction

" turn off cursorline because it makes scrolling slow
set nocursorline

" au VimEnter,WinEnter,BufWinEnter * call FlashCursor()

" CtrlP plugin
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_md = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" ignore silly files and directores from CtrlP search
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" dont set sparkup mappings by default
let g:sparkupNextMapping = '<nop>'

" set sparkup mappings for html files
" autocmd FileType html let g:sparkupMaps=1

" config netrw a bit
autocmd FileType netrw setlocal bufhidden=wipe
let g:netrw_list_hide= '.*\.swp$'
let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.swp$'

" spelling
" ref: https://github.com/bruno-/dotfiles/blob/master/home/.vimrc
set spelllang=en_us                      " spelling options
set spellfile=~/.vim/spell/en.utf-8.add  " spell files added with `zg`

" load dictionaries based on filetype
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

" use npm script lint as by default ( for vim's built in quickfix )
" (:make, :copen, :cn, :cp, etc)
set makeprg=npm\ run\ lint\ --silent
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

command! Scratch :new | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
command! ScratchThis :setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile

command! GitBlame :new | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile | r !git blame #

" use some other default makeprg based on filetype
" autocmd Filetype foo setlocal makeprg=/bin/foo


" holy fucking shit!!!!!
" set grepprg=rg\ --vimgrep
" set grepprg=grep\ --ignore-case\ --fixed-strings
" set grepprg=grep\ --color\ -iF

" useful grep
" set grepprg=grep\ -rn
set grepprg=grep\ --exclude=*node_modules*\ --exclude=*.git/*\ -n

" set ripgrep as default grep program if it exists
" --vimgrep : every result in its own line
"  -S       : smart case
"  -u       : add .ignored files in search
"  -M 200   : ignore lines longer than 200 column width ( practically ignores minified
"  files )
if executable('rg')
  set grepprg=rg\ --vimgrep\ -S\ -M\ 200
endif

set background=dark

" let g:gruvbox_contrast='medium'
" let g:gruvbox_contrast_light='medium'
" let g:gruvbox_contrast_dark='medium'

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

" sample electron app snippet
nnoremap snipe :-1read $HOME/.vim/snippets/electron-app.js<CR>

" sample README.md snippet
nnoremap snipr m':-1read $HOME/.vim/snippets/README.md<CR>''/\$NAME<CR>

" sample npm scripts snippet
nnoremap snips m':-1read $HOME/.vim/snippets/npm-scripts.txt<CR>''/\$NAME<CR>

" sample .gitignore snippet
nnoremap snipi :-1read $HOME/.vim/snippets/gitignore<CR>

" sample env snippet
nnoremap snipn :-1read $HOME/.vim/snippets/env.js<CR>

" sample color snippet
nnoremap snipc :-1read /Users/mollie/.vim/snippets/colors.txt<CR>

" md means markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" Generic highlighting
" https://github.com/j16180339887/Global.vim/blob/master/plugin/Global.vim
autocmd BufNewFile,BufReadPost * call HighlightGlobal()
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
endfunction-

highlight StatusLineFileName ctermfg=black ctermbg=gray
highlight StatusLineModifiedFlag ctermfg=NONE ctermbg=red

augroup SetStatusLineHighlights
  autocmd!
  autocmd ColorScheme * silent hi StatusLineFileName
augroup END

" statusline setup
set statusline=[%{pathshorten(getcwd())}] "display shortened path of current directory
set statusline+=\        "a space before the filename

set statusline+=%#StatusLineFileName# "put gray background around filename
set statusline+=%t       "tail of the filename
set statusline+=%*      "reset highlight grup to defaults

set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag

set statusline+=%#StatusLineModifiedFlag# "put red background around modified flag
set statusline+=%m      "modified flag
set statusline+=%*      "reset highlight grup to defaults

set statusline+=%r      "read only flag
set statusline+=%y      "filetype


set statusline+=%=      "left/right separator


set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"
" Selectively cherry picked highlights from
" https://github.com/jelera/vim-javascript-syntax/blob/master/syntax/javascript.vim
" https://github.com/pangloss/vim-javascript/blob/master/syntax/javascript.vim


function! ExtraHighlights()
  if &filetype == "javascript" || &filetype == "typescript"
    "" syntax coloring for Node.js shebang line
    syntax match shebang "^#!.*"
    hi link shebang Comment

    syntax match   jsFuncCall       /\<\K\k*\ze\s*(/

    " keywords
    syntax keyword jsGlobalNodeObjects  module exports global process __dirname __filename
    syntax match   jsGlobalNodeRequire  /\<require\>/ containedin=jsFuncCall

    hi link jsGlobalNodeObjects Constant
    " hi link jsGlobalNodeRequire javaScriptIdentifier
    " hi link jsGlobalNodeRequire javaScriptMember
    hi link jsGlobalNodeRequire javaScriptMember

    " Statement Keywords {{{
    " syntax keyword jsSource         import export from
    syntax keyword javaScriptIdentifier     arguments this let var void yield async await const
    " syntax keyword jsOperator       delete new instanceof typeof
    " syntax keyword jsBoolean        true false
    " syntax keyword jsNull           null undefined
    " syntax keyword jsMessage        alert confirm prompt status

    " syntax keyword jsGlobal         self top parent
    " syntax keyword jsDeprecated     escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
    " syntax keyword jsConditional    if else switch
    " syntax keyword jsRepeat         do while for in of
    " syntax keyword jsBranch         break continue
    syntax keyword _jsLabel          case default
    syntax keyword _jsPrototype      prototype
    " syntax keyword jsStatement      return with
    syntax keyword _jsGlobalObjects  Array Boolean Date Function Math Number Object RegExp String
    " syntax keyword jsExceptions     try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
    " syntax keyword jsReserved       abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws goto private transient debugger implements protected volatile double import public
    "}}}

    hi link _jsLabel javaScriptType
    hi link _jsPrototype javaScriptType
    hi link _jsGlobalObjects javaScriptType

    syntax keyword _jsInfinity           Infinity
    hi link _jsInfinity javaScriptNumber

    "  DOM, Browser and Ajax Support   {{{
    syntax keyword _jsBrowserObjects           window navigator screen history location console

    hi link _jsBrowserObjects javascriptGlobal

    syntax keyword _jsDOMObjects               document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
    syntax keyword _jsDOMMethods               createTextNode createElement insertBefore replaceChild removeChild appendChild  hasChildNodes  cloneNode  normalize  isSupported  hasAttributes  getAttribute  setAttribute  removeAttribute  getAttributeNode  setAttributeNode  removeAttributeNode  getElementsByTagName  hasAttribute  getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
    " syntax keyword _jsDOMProperties            nodeName  nodeValue  nodeType  parentNode  childNodes  firstChild  lastChild  previousSibling  nextSibling  attributes  ownerDocument  namespaceURI  prefix  localName  tagName

    hi link _jsDOMObjects javaScriptFunction
    hi link _jsDOMMethods javaScriptMember
    " hi link _jsDOMProperties javaScriptMember

    syntax keyword _jsExceptions         Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
    syntax keyword _jsBuiltins           decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval

    hi link _jsExceptions GruvboxYellow
    hi link _jsBuiltins javaScriptMember

    syntax keyword _jsAjaxObjects              XMLHttpRequest
    " syntax keyword jsAjaxProperties           readyState responseText responseXML statusText
    " syntax keyword jsAjaxMethods              onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

    " syntax keyword jsPropietaryObjects        ActiveXObject
    " syntax keyword jsPropietaryMethods        attachEvent detachEvent cancelBubble returnValue

    " syntax keyword jsHtmlElemProperties       className  clientHeight  clientLeft  clientTop  clientWidth  dir  href  id  innerHTML  lang  length  offsetHeight  offsetLeft  offsetParent  offsetTop  offsetWidth  scrollHeight  scrollLeft  scrollTop  scrollWidth  style  tabIndex  target  title

    " syntax keyword jsEventListenerKeywords    blur click focus mouseover mouseout load item

    " syntax keyword jsEventListenerMethods     scrollIntoView  addEventListener  dispatchEvent  removeEventListener preventDefault stopPropagation
    " }}}

    hi link _jsAjaxObjects javaScriptMember

    " ES6 String Interpolation {{{
    syntax match  javaScriptTemplateDelim    "\${\|}" contained
    syntax region javaScriptTemplateVar      start=+${+ end=+}+                        contains=javaScriptTemplateDelim keepend
    syntax region javaScriptTemplateString   start=+`+  skip=+\\\(`\|$\)+  end=+`+     contains=javaScriptTemplateVar,javaScriptSpecial keepend
    "}}}

    hi link javaScriptTemplateDelim          javaScriptBraces
    hi link javaScriptTemplateString         String
  endif
endfunction-

call ExtraHighlights()

augroup AutoExtraHighlights
  autocmd!
  autocmd BufNewFile,BufReadPost * call ExtraHighlights()
augroup END

" syntax match   jsFuncCall       /\<\K\k*\ze\s*(/

" keywords
" syntax keyword jsGlobalObjects      Array Boolean Date Function Iterator Number Object Symbol Map WeakMap Set WeakSet RegExp String Proxy Promise Buffer ParallelArray ArrayBuffer DataView Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray JSON Math console document window Intl Collator DateTimeFormat NumberFormat fetch
" syntax keyword jsGlobalNodeObjects  module exports global process __dirname __filename
" syntax match   jsGlobalNodeObjects  /\<require\>/ containedin=jsFuncCall

" hi link jsGlobalObjects Constant

"
" basically just template string and common nodejs/javascript keywords
"
" Strings, Templates, Numbers
" syntax region  jsString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=jsSpecial,@Spell extend
"" syntax region  jsTemplateString   start=+`+  skip=+\\`+  end=+`+     contains=jsTemplateExpression,jsSpecial,@Spell extend
" syntax match   jsTaggedTemplate   /\<\K\k*\ze`/ nextgroup=jsTemplateString
" syntax match   jsNumber           /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
"" syntax keyword jsNumber           Infinity
" syntax match   jsFloat            /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/

" Keywords
"" syntax keyword jsGlobalObjects      Array Boolean Date Function Iterator Number Object Symbol Map WeakMap Set WeakSet RegExp String Proxy Promise Buffer ParallelArray ArrayBuffer DataView Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray JSON Math console document window Intl Collator DateTimeFormat NumberFormat fetch
"" syntax keyword jsGlobalNodeObjects  module exports global process __dirname __filename
"" syntax match   jsGlobalNodeObjects  /\<require\>/ containedin=jsFuncCall
"" syntax keyword jsExceptions         Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
"" syntax keyword jsBuiltins           decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval
" DISCUSS: How imporant is this, really? Perhaps it should be linked to an error because I assume the keywords are reserved?
"" syntax keyword jsFutureKeys         abstract enum int short boolean interface byte long char final native synchronized float package throws goto private transient implements protected volatile double public

" Regular Expressions
" syntax match   jsSpecial            contained "\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)"
"" syntax region  jsTemplateExpression contained matchgroup=jsTemplateBraces start=+${+ end=+}+ contains=@jsExpression keepend

"" hi link jsSpecial              Special
"" hi link jsTemplateBraces       Noise

fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun

" ref: http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <F9> :call ShowFuncName() <CR>

" nnoremap [[ ?{<CR>w99[{
" nnoremap ][ /}<CR>b99]}
" nnoremap ]] j0[[%/{<CR>
" nnoremap [] k$][%?}<CR>

" see: https://github.com/prabirshrestha/vim-lsp
" and install: npm i -g bash-language-server
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'whitelist': ['sh'],
        \ })
endif

" ref: https://github.com/vim/vim/issues/549
" Use relative paths in buffer list
" autocmd BufReadPost * silent! lcd .
