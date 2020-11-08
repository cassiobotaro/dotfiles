" Auto install Vim Plug
let vimplug_exists=expand(stdpath('data') . '/site/autoload/plug.vim')
if !filereadable(vimplug_exists)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-airline/vim-airline' |  Plug 'vim-airline/vim-airline-themes'            " statusline/tabline themes(keep on top)
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                                " snippets
Plug 'airblade/vim-gitgutter'                                                      " git diff in a gutter(sign column)
Plug 'tpope/vim-commentary'                                                        " Comment stuff out
Plug 'tpope/vim-fugitive'                                                          " git inside vim
Plug 'tpope/vim-surround'                                                          " quoting/parenthesizing made simple
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                  " fzf full installation
Plug 'junegunn/fzf.vim'                                                            " fzf vim plugin
Plug 'ryanoasis/vim-devicons'                                                      " dev icons
Plug 'tomasiser/vim-code-dark'                                                     " colorscheme
Plug 'dense-analysis/ale'                                                          " linter
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}                             " dockerfile
Plug 'davidhalter/jedi-vim'                                                        " python complete and refactors
Plug 'jeetsukumaran/vim-pythonsense'                                               " text objects and motions for python
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}                     " go plugin
Plug 'mateusbraga/vim-spell-pt-br'                                                 " pt-br spell checker
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
call plug#end()


" Configurations
let mapleader = ','                                             " set leader shortcut to comma
let g:loaded_python_provider=0                                  " disable python 2 provider
let g:python3_host_prog="/home/cassiobotaro/.pyenv/versions/3.9.0/bin/python3" " python 3
set clipboard+=unnamedplus                                      " set clipboard
set termguicolors 						                        " Enables 24-bit RGB color
set shortmess+=I 						                        " remove nvim intro message
set noswapfile                                                  " avoid swap files
set nobackup                                                    " avoid bkp files
set nowritebackup                                               " no make a backup before overwriting file
set undofile                                                    " persistent undo
set undolevels=1000                                             " maximum number of changes that can be undone
set undoreload=10000                                            " maximum number lines to save for undo on a buffer reload
set showbreak=↪                                                 " show arrow at wrap
set hidden                                                      " allow buffer switching without saving
set autowrite                                                   " write the content of the file automatically when call :make
set ignorecase                                                  " ignore case omnifunc search
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__          " ignore files matching these patterns when opening files based on a glob pattern
set shiftwidth=4						                        " operation >> indents 4 columns; << unindents 2 columns
set tabstop=4							                        " a hard TAB displays as 4 columns
set expandtab							                        " insert spaces when hitting TABs
set softtabstop=4						                        " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround							                        " round indent to multiple of 'shiftwidth'
set autoindent							                        " align the new line indent with the previous line
set updatetime=300                                              " update quickly
set omnifunc=syntaxcomplete#Complete                            " enable autocomplete
set noshowmode                                                  " don't show pressed commands
filetype plugin indent on                                       " recognizes filetype, plugins and indent
syntax on                                                       " syntax highlight
silent! colorscheme codedark                                    " colorscheme codedark
au FileType markdown setl spelllang=pt_br,en spell


" Remaps
" split horizontally
noremap <Leader>h :<C-u>split<CR>
" split vertically
noremap <Leader>v :<C-u>vsplit<CR>
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
" move to previous buffer
noremap <leader>q :bp<CR>
" move to next buffer
noremap <leader>w :bn<CR>
" close buffer
noremap <leader>c :bd<CR>
" set working directory
nnoremap <leader>. :lcd %:p:h<CR>
"" vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv


" Auto Commands
" remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e
" remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" close preview automatically
aug completion_preview_close
  au!
  au CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
aug END

" Commands
" fix python import (based on isort)
command! -nargs=* -range=% FixPythonImports :<line1>,<line2>! isort <args>
" execute black on file
command! -nargs=* -range=% Black :! black <args> %


" Plugin Configurations
" airline configs
let g:airline_symbols = {}
let g:airline_theme = 'minimalist'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline_symbols.linenr    = '␊'
let g:airline_symbols.branch    = '⎇'
let g:airline_symbols.paste     = 'ρ'
let g:airline_symbols.paste     = 'Þ'
let g:airline_symbols.paste     = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"
autocmd FileType python setlocal completeopt-=preview

" fzf
" list buffers
nnoremap <silent> <leader>b :Buffers<CR>
" list files in current directory
nnoremap <silent> <leader>e :GFiles<CR>
" find some text
nnoremap <silent> <leader>f :Rg<CR>
set grepprg=rg\ --vimgrep

" UtilSnips
" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" vim-markdown
let g:vim_markdown_folding_disabled = 1
set conceallevel=2
