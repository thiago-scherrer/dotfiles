let g:make = 'make'
call plug#begin('~/.vim/plugged')
let g:vim_bootstrap_frams = ""

Plug 'Raimondi/delimitMate'
Plug 'Shougo/vimproc.vim', {'do': g:make}
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'editor-bootstrap/vim-bootstrap-updater'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'
Plug 'nvie/vim-flake8'
Plug 'tell-k/vim-autopep8'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/CSApprox'

" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

set backspace=indent,eol,start

set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

let mapleader=','

set hidden

set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

set shell=/bin/zsh

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

syntax on
set ruler
set number

let no_buffers_menu=1

set wildmenu

set mouse=a

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  let g:CSApprox_loaded = 1

  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1


  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif

endif

if &term =~ '256color'
  set t_ut=
endif

set gcr=a:blinkon0

set scrolloff=3

set laststatus=2

set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" vim-airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

command! FixWhitespace :%s/\s\+$//e

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

set autoread

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>


nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_linters = {}
:call extend(g:ale_linters, {
    \'python': ['flake8'], })

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

noremap <C-C> :call system("xclip -selection clipboard", @")<CR><CR>

noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

noremap <leader>c :bd<CR>

nnoremap <silent> <leader><space> :noh<cr>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"vmap < <gv
"vmap > >gv

"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
autocmd BufEnter *.go nmap <space>i  <Plug>(go-info)
autocmd BufEnter *.go nmap <space>ii  <Plug>(go-implements)
autocmd BufEnter *.go nmap <space>ci  <Plug>(go-describe)
autocmd BufEnter *.go nmap <space>cc  <Plug>(go-callers)
nmap <C-a> <C-o>
nmap <C-d> <Plug>(coc-definition)

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go

  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

let g:javascript_enable_domhtmlcss = 1
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

let python_highlight_all = 1
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
let g:yats_host_keyword = 1

autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

let g:airline#extensions#virtualenv#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
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
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" terminal
nnoremap <F2> :zsh<cr>

let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
let g:terraform_fold_sections = 0

inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nnoremap <CR> :noh <CR><CR>

" Terraform template
au BufNewFile,BufRead,BufReadPost *.tpl set syntax=bash

" Custom bkp file
set directory=$HOME/tmp/
set backupdir=$HOME/tmp/
set undodir=$HOME/tmp/

" fugitive git bindings
nnoremap <space>ga :Git add %<CR><CR>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>gc :Git commit -v -q<CR>
nnoremap <space>gdd :Gvdiffsplit!<CR>
nnoremap <space>ge :Git edit<CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gp :Git grep<Space>
nnoremap <space>gpl :! git fetch && git rebase<CR>
nnoremap <space>gpll :Git rebase <CR>
nnoremap <space>gpp :Git rebase -i origin/main <CR>
nnoremap <space>gps :Git -c push.default=current push<CR>
nnoremap <space>gs :Git status<CR>
nnoremap <space>gw :Git write<CR><CR>
nnoremap <space>gll :Git pull<CR>
nnoremap <space>pr :! gh pr create -a "@me" <CR>
nnoremap <space>prr :! gh pr merge -s -d <CR>

nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

set background=dark
highlight Normal ctermbg=None
highlight nonText ctermbg=None
highlight clear LineNr
highlight clear CursorLineNr
set signcolumn=yes
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=red

