" Auto install Vim Plug
let vimplug_exists=expand(stdpath('data') . '/site/autoload/plug.vim')
if !filereadable(vimplug_exists)
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins
call plug#begin(stdpath('data') . '/plugged')
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
Plug 'alfredodeza/pytest.vim'                                                      " pytest inside vim
Plug 'fisadev/vim-isort'                                                           " python sort imports
Plug 'psf/black'                                                                   " python formatter
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}                      " requirements format syntax support for Vim
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}                     " go plugin
Plug 'mateusbraga/vim-spell-pt-br'                                                 " pt-br spell checker
Plug 'cespare/vim-toml'                                                            " vim syntax for TOML.
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
call plug#end()


" Configurations
let mapleader = ','                                             " set leader shortcut to comma
let g:loaded_python_provider=0                                  " disable python 2 provider
let g:python3_host_prog="/home/cassiobotaro/.pyenv/versions/3.9.5/bin/python3" " python 3
set clipboard+=unnamedplus                                      " set clipboard
set termguicolors 						" Enables 24-bit RGB color
set shortmess+=I 						" remove nvim intro message
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
set shiftwidth=4						" operation >> indents 4 columns; << unindents 2 columns
set tabstop=4							" a hard TAB displays as 4 columns
set expandtab							" insert spaces when hitting TABs
set softtabstop=4						" insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround							" round indent to multiple of 'shiftwidth'
set autoindent							" align the new line indent with the previous line
set updatetime=300                                              " update quickly
set omnifunc=syntaxcomplete#Complete                            " enable autocomplete
set noshowmode                                                  " don't show pressed commands
filetype plugin indent on                                       " recognizes filetype, plugins and indent
syntax on                                                       " syntax highlight
silent! colorscheme codedark                                    " colorscheme codedark
au FileType markdown setl spelllang=pt_br,en spell              " spellcheck on markdown
set signcolumn=yes                                              " keep sign column (gutter)


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
" vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>


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

" Plugin Configurations

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
nnoremap <silent> <leader>e :Files<CR>
" find some text
nnoremap <silent> <leader>f :Rg<CR>
set grepprg=rg\ --vimgrep

" UtilSnips
" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_ok = 'ﲏ'
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" statuslines
set statusline=
set statusline+=\                                              " vim symbol
set statusline+=\ \\|                                           " separator
set statusline+=\ %{GitBranchStatusline()}                      " display git branch label
set statusline+=\ %{GitStatus()}
set statusline+=\ \\|                                           " separator
set statusline+=\ 
set statusline+=\ %{expand('%:~:.')}                            " display path directory
set statusline+=\                                               " white space
set statusline+=\%{ReadOnlyStatusline()}                        " display read only icon
set statusline+=\%{PasteStatusline()}%*                         " display paste mode icon
set statusline+=\ %=                                            " split point for left and right groups
set statusline+=\ %l                                            " row number
set statusline+=\                                              " colon separator
set statusline+=%v                                              " column number
set statusline+=\                                              " line number icon
set statusline+=\ \\|                                           " separator
set statusline+=\ %{WebDevIconsGetFileFormatSymbol()}           " file format icon
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}      " current file encoding
set statusline+=\ \\|                                           " separator
set statusline+=\ %{LinterStatusline()}                         " linter status
set statusline+=\ \\|                                           " separator
set statusline+=\%{VimModeStatusline()}                        " display actual vim mode

" statusline functions
let s:mode_map = {
        \ 'n':      ' NORMAL ',
        \ 'no':     ' NO     ',
        \ 'v':      ' V-CHAR ',
        \ 'V':      ' V-LINE ',
        \ "\<C-v>": ' V-BLCK ',
        \ 's':      ' S-CHAR ',
        \ 'S':      ' S-LINE ',
        \ "\<C-s>": ' S-B    ',
        \ 'i':      ' INSERT ',
        \ 'ic':     ' I-COMP ',
        \ 'ix':     ' I-COMP ',
        \ 'R':      ' R      ',
        \ 'Rc':     ' R-COMP ',
        \ 'Rv':     ' R-VIRT ',
        \ 'Rx':     ' R-COMP ',
        \ 'c':      ' C-LINE ',
        \ 'cv':     ' EX     ',
        \ 'ce':     ' EX     ',
        \ 'r':      ' ENTER  ',
        \ 'rm':     ' MORE   ',
        \ 'r?':     ' ?      ',
        \ '!':      ' SHELL  ',
\ }

function! VimModeStatusline()
    let l:mode = mode()
    return has_key(s:mode_map, l:mode) ? s:mode_map[l:mode] : ''
endfunction

function! LinterStatusline() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error
    let l:all_non_errors = l:counts.total - l:all_errors
    if l:counts.total > 0
        return printf('%s: %d %s: %d', g:ale_sign_error, all_errors, g:ale_sign_warning, all_non_errors)
    endif
    return printf('%s', g:ale_sign_ok)
endfunction

function! ModifiedStatusline()
    if &modified == 1
        return '  '
    endif
    return ''
endfunction

function! ReadOnlyStatusline()
    if &readonly == 1
        return '  '
    endif
    return ''
endfunction

function! PasteStatusline()
    if &paste == 1
        return '  '
    endif
    return ''
endfunction

function! GitBranchStatusline()
    let l:branch_name = fugitive#head()
    if l:branch_name != ""
        return printf(' %s', branch_name)
    endif
    return ''
endfunction

function! FilenameStatusline()
    let l:filetype_symbol = WebDevIconsGetFileTypeSymbol()
    let l:filetype_name = expand('%:t')
    return printf(' %s %s ', filetype_symbol, filetype_name)
endfunction
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
