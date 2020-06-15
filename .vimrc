[ -n "$PS1" ] && source ~/.bash_profile;
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
export LD_PRELOAD="/home/vagrant/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
#Fish syntax
# set -gx FZF_DEFAULT_COMMAND  'rg --files --follow --hidden'
vagrant@ubuntu-eoan:~$ cd .vim
vagrant@ubuntu-eoan:~/.vim$ cd ..
vagrant@ubuntu-eoan:~$ cat .vomrc
cat: .vomrc: No such file or directory
vagrant@ubuntu-eoan:~$ cat .vimrc
"Use the Solarized Dark themS
"
set background=dark
colorscheme PaperColor
let g:solarized_termtrans=1

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
"HORIZONTAL SPLIT"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
"VERTICAL SPLIT"
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"SEARCH FOR FILE"
nnoremap <C-p> :Files<CR>


"travel between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"travel between windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

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
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"FZF
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
 xmap <leader><tab> <plug>(fzf-maps-x)
 omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
 imap <c-x><c-k> <plug>(fzf-complete-word)
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
call plug#end()