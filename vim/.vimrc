set clipboard^=unnamed,unnamedplus
set guioptions+=a

syntax on

set path+=**
set nocompatible
set wildmenu

set number

set tabstop=2
set shiftwidth=2
set backspace=2

set showmatch " Show matching brackets.
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching
set incsearch " Incremental search
set nohlsearch

" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8

" Automatically wrap text that extends beyond the screen length.
set wrap

set expandtab
set noshiftround

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

autocmd VimEnter * NERDTree | wincmd p

" NERDTree
let NERDTreeWinSize = 19
let NERDTreeAutoDeleteBuffer = 1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.swp']
:nnoremap <C-g> :NERDTreeToggle<CR>

" Minimalist-TabComplete-Plugin
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

" Minimalist-AutoCompletePop-Plugin
set completeopt=menu,menuone,noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-P>", 'n')
    end
endfun

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:terraform_fold_sections=0

" Golang
filetype plugin indent on
set backspace=indent,eol,start
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
au filetype go inoremap <buffer> . .<C-x><C-o>

" airline theme
let g:airline_theme='base16_summerfruit'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_symbols.notexists = ''
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty=''

