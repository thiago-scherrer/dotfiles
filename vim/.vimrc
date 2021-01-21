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

filetype plugin indent on

set showmatch " Show matching brackets.
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching
set incsearch " Incremental search
set nohlsearch

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

" Status bar
set laststatus=2

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %p%%
set statusline+=\ %l:%c

autocmd VimEnter * NERDTree | wincmd p
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrowExpandable = '▸'
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.swp']

" Thanks @BMilliet \o/
" Auto complete menu
inoremap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

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
