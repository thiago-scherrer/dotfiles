highlight Pmenu ctermbg=Gray ctermfg=White
highlight Pmenu guibg=gray10 guifg=LightSteelBlue4
highlight PmenuSel ctermbg=Black ctermfg=White
highlight PmenuSel guibg=gray10 guifg=LightSteelBlue1
set backspace=2
set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set guioptions+=a
set ignorecase " Do case insensitive matching
set incsearch " Incremental search
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set matchpairs+=<:>
set nocompatible
set nohlsearch
set noshiftround
set number
set path+=**
set scrolloff=5
set shiftwidth=2
set showmatch " Show matching brackets.
set smartcase " Do smart case matching
set tabstop=2
set ttyfast
set wildmenu
set wrap
syntax on

" NERDTree
" autocmd VimEnter * NERDTree | wincmd p
let NERDTreeWinSize = 19
let NERDTreeAutoDeleteBuffer = 1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.swp']
:nnoremap <C-g> :NERDTreeToggle<CR>
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun
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
au filetype go inoremap <buffer> . .<C-x><C-o>
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
filetype plugin indent on
let g:go_addtags_transform = "camelcase"
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
set backspace=indent,eol,start
set updatetime=100

" airline theme
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty=''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.readonly = ''
let g:airline_theme='base16_summerfruit'

" JS
let g:javascript_plugin_jsdoc = 1

" Ctags
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir='~/.ctags'
nmap <F8> :TagbarToggle<CR>
