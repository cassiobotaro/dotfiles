" Heavily inspired by @drgarcia1986 and vim-bootstrap

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible " Use Vim defaults instead of 100% vi compatibility
" CVE-2007-2438
set modelines=0


" Auto install Vim Plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif


"  Plugins

call plug#begin('~/.vim/plugged/')
Plug 'vim-airline/vim-airline' |  Plug 'vim-airline/vim-airline-themes'            " statusline/tabline themes(keep on top)
Plug 'airblade/vim-gitgutter'                                                      " git diff in a gutter(sign column)
Plug 'tpope/vim-commentary'                                                        " Comment stuff out
Plug 'tpope/vim-fugitive'                                                          " git inside vim
Plug 'tpope/vim-surround'                                                          " quoting/parenthesizing made simple
Plug 'sheerun/vim-polyglot'                                                        " support for many languages
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                                " snippets
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                  " fzf full installation
Plug 'junegunn/fzf.vim'                                                            " fzf vim plugin
Plug 'tomasr/molokai'                                                              " colorscheme
Plug 'w0rp/ale'                                                                    " linter
Plug 'ryanoasis/vim-devicons'                                                      " dev icons
Plug 'corylanou/vim-present', {'for' : 'present'}                                  " go present
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}                             " dockerfile
Plug 'maralla/completor.vim'                                                       " autocomplete
Plug 'alfredodeza/pytest.vim', {'for': 'python'}                                   " run pytest inside vim
Plug 'davidhalter/jedi-vim', {'for': 'python'}                                     " python plugin
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}                     " go plugin
Plug 'buoto/gotests-vim', {'for': 'go'}                                            " generate tests for go
Plug 'sebdah/vim-delve', {'for': 'go'}                                             " go debugger
call plug#end()


" Configurations

let mapleader = ","                                             " set leader shortcut to a comma

set t_Co=256                                                    " display 256 colors
set backup
set backupdir=~/.cache/nvim                                     " directory to store backup files
set directory=~/.cache/nvim                                     " directory to store swap files
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

silent! colorscheme molokai                                     " colorscheme
filetype plugin indent on                                       " recognize filetype, plugins and indent
syntax on                                                       " enable syntax highlight


" Key maps

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


" Plugins

" airline configs
let g:airline_symbols = {}
let g:airline_theme = 'term'
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


"" fzf.vim
set grepprg=ag\ --nogroup\ --nocolor
set grepformat=%f:%l:%c:%m,%f:%l:%m
" list buffers
nnoremap <silent> <leader>b :Buffers<CR>
" list files in current directory
nnoremap <silent> <leader>e :FZF -m<CR>
" find some text
nnoremap <silent> <leader>f :Ag<CR>


" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e
" fix python import (based on isort)
command! -nargs=* -range=% FixPythonImports :<line1>,<line2>! isort <args> -
" Save with root privilege
command! Wroot :execute ':silent w !sudo tee % > /dev/null' | :edit!


" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)
  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
augroup END
let g:go_gocode_unimported_packages = 1
au FileType go set foldmethod=syntax
au FileType go set nofoldenable
let g:go_fold_enable = ['block', 'import', 'varconst']
let g:go_decls_mode='fzf'

" jedi-vim
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0


" ALE
let g:ale_linters = {
\	'go': ['go build', 'go vet', 'golint'],
\	'python': ['flake8']
\}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = '✖'
let g:ale_sign_warning = ''
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
" jump to prev/next quickfix results
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
