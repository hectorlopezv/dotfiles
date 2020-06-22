
"Enable folding

set foldmethod=indent
set foldlevel=99

"Enable folding with the spacebar
nnoremap <space> za


" Make Vim more useful
set nocompatible
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" B
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" B
" hange mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4
" Enable auto indenting
set autoindent
set cindent
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	" Trim white spaces on c and python
	autocmd BufWritePre *.c,*.py :%s/\s\+$//e
	"Fix indent on C and Python
	autocmd BufWritePre *.c,*.py :normal gg=G
	"Trim blank lines in the end of file
	autocmd BufWritePre *.c,*.py $put _ | $;?\(^\s*$\)\@!?+2,$d


endif

" Commands for splitting windows
set splitbelow
set splitright
"vertical split
nnoremap <leader>v :split<enter>
"horizontal split
nnoremap <leader>o :vsplit<enter>
"opening table
nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-D> :tabclose<CR>

"SEARCH FOR FILE"
nnoremap <C-p> :Files<CR>


"travel between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"move beetween split panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"ale jump between lintin error"
nmap <silent> . <Plug>(ale_previous_wrap)
nmap <silent> - <Plug>(ale_next_wrap)'

"prettier commnad"
let g:ale_fixers= {'javascript' : ['eslint']}

" Fix files automatically on save"
let g:ale_fix_on_save = 1
nmap <F6> <Plug>(ale_fix)
" Fix files automatically on save"


"tags search
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"FZF
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-wod)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"

" Vertical linex
let g:indentLine_enabled = 1
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif




call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/WolfgangMehner/c-support.git'

"los del video
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
call plug#end()
nmap <leader>s <Plug>(easymotion-s2)
nmap <leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
colorscheme gruvbox

let g:gruvbox_contrast_dark = "hard"
:set bg=dark

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"e K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding
" the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>

