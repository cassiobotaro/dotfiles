scriptencoding utf-8

" Auto install Vim Plug
let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

if !filereadable(vimplug_exists)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'                                                      " git diff in a gutter(sign column)
Plug 'tpope/vim-commentary'                                                        " Comment stuff out
Plug 'tpope/vim-fugitive'                                                          " git inside vim
Plug 'tpope/vim-surround'                                                          " quoting/parenthesizing made simple
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                                " snippets
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                  " fzf full installation
Plug 'junegunn/fzf.vim'                                                            " fzf vim plugin
Plug 'tomasr/molokai'                                                              " colorscheme
Plug 'w0rp/ale'                                                                    " linter
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}                             " dockerfile
Plug 'alfredodeza/pytest.vim', {'for': 'python'}                                   " run pytest inside vim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }          " markdown preview
Plug 'davidhalter/jedi-vim'
call plug#end()

" Configurations
let mapleader = ','                                             " set leader shortcut to a comma
set t_Co=256                                                    " display 256 colors
set noswapfile                                                  " avoid swap files
set nobackup                                                    " avoid bkp files
set nowritebackup                                               " no make a backup before overwriting file
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set number                                                      " show line numbers on the sidebar
set showbreak=↪                                                 " show arrow at wrap
set hidden                                                      " allow buffer switching without saving
set updatetime=250                                              " pretty much just so gittgutter will update quickly
set clipboard=unnamed,unnamedplus                               " set clipboard
set cursorline                                                  " highlight current line
set lazyredraw                                                  " don’t update screen during macro and script execution
set noshowmode                                                  " don't show pressed commands
set ignorecase                                                  " ignore case omnifunc search
set shortmess+=A                                                " avoid locking popup messages
set omnifunc=syntaxcomplete#Complete                            " enable autocomplete
set autowrite                                                   " write the content of the file automatically when call :make
set list
set listchars=trail:-,tab:\ \ ,                                 " show trailing whitespace
set wildmode=list:longest,list:full                             " completion mode that is used for the character specified with wildchar
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern
set shiftwidth=4						" operation >> indents 4 columns; << unindents 2 columns
set tabstop=4							" a hard TAB displays as 4 columns
set expandtab							" insert spaces when hitting TABs
set softtabstop=4						" insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround							" round indent to multiple of 'shiftwidth'
set autoindent							" align the new line indent with the previous line
filetype plugin indent on                                       " recognizes filetype, plugins and indent
syntax on
silent! colorscheme molokai                                     " colorscheme

" Split
" horizontally
noremap <Leader>h :<C-u>split<CR>
" vertically
noremap <Leader>v :<C-u>vsplit<CR>
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
" Buffer actions
" move to previoues buffer
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
" move to next buffer
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
" close buffer
noremap <leader>c :bd<CR>
"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


" Closes buffer and quicklist too
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" close preview automatically
aug completion_preview_close
  au!
  au CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
aug END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e
" fix python import (based on isort)
command! -nargs=* -range=% FixPythonImports :<line1>,<line2>! isort <args> -


"" fzf.vim
set grepprg=ag\ --nogroup\ --nocolor
set grepformat=%f:%l:%c:%m,%f:%l:%m
" list buffers
nnoremap <silent> <leader>b :Buffers<CR>
" list files in current directory
nnoremap <silent> <leader>e :FZF -m<CR>
" find some text
nnoremap <silent> <leader>f :Ag<CR>

" ALE
let g:ale_linters = {
\	'python': ['flake8']
\}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
" jump to prev/next quickfix results
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"
autocmd FileType python setlocal completeopt-=preview
let g:python3_host_prog = "~/.pyenv/shims/python"
