call plug#begin('~/.vim/plugged')
" Plug 'vim-syntastic/syntastic'
" Plug 'tpope/vim-vinegar'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mbbill/undotree'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'puremourning/vimspector'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'mattn/ctrlp-lsp', { 'branch': 'main' }

call plug#end()

if has('multi_byte')
  if empty(&termencoding)
    let &termencoding = &encoding
  endif
  let &encoding     = 'utf-8'
  let &fileencoding = 'utf-8'
endif

set termguicolors

if !has('nvim')
  set pythonthreedll=python38.dll
endif

if !empty($CONEMUBUILD)
  if !has('nvim')
    set term=xterm
  endif
  " let &t_AB="\e[48;5;%dm"
  " let &t_AF="\e[38;5;%dm"
  " inoremap <Char-0x07F> <BS>
  " nnoremap <Char-0x07F> <BS>
endif

set t_Co=256

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h9
set guifont=DejaVuSansMono\ NF:h9

syntax enable

set background=dark
colorscheme NeoSolarized

set backspace=2
set number
set autoindent

let mapleader = ','

set pastetoggle=<F2>
if has("unix")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

set hlsearch
set incsearch
"case-insensitive searching
set ignorecase
"unless there's a capital letter there
set smartcase

set showcmd
" mode already on airline
set noshowmode

" Always shows 5 lines above/below the cursor
set scrolloff=5

" completion in command mode
set wildmenu

" nicer buffer handling
set hidden

" Set the tag file search order
set tags=./tags;

set laststatus=2

" Leader mappings
nnoremap <Leader>en :set spell! spelllang=en<CR>
nnoremap <Leader>sk :set spell! spelllang=sk<CR>

map <Leader>t <esc>:tabnew<CR>
map <Leader>x <C-w>c

nnoremap <Leader>l <esc>:nohl<CR>
vnoremap <Leader>l <esc>:nohl<CR>
inoremap <Leader>l <esc>:nohl<CR>

" sort the selection
vnoremap <Leader>s :sort<CR>

" 80 char line
nnoremap <leader>cc :execute "set cc=" . (&cc == "" ? "80" : "")<CR>

" better command line edditing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-h> <t_kl>
cnoremap <C-l> <t_kr>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" exit insert mode, prevent one char left
imap jk <Esc>`^
" end insert mode in terminal
:tnoremap jk <C-\><C-n>

nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" yanking behaviour consistent with D and C
nnoremap Y y$

" saving when root permission needed
cmap w!! %!sudo tee > /dev/null %

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" reselect after indentation
vnoremap < <gv
vnoremap > >gv

" movement through splits simplified
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" spell check style
hi clear Spellbad
hi SpellBad cterm=underline ctermfg=red

augroup vimrc_autocmd
  autocmd!

  " tabs vs spaces
  " python
  au FileType python setl ts=8 sts=4 sw=4 et
  " golang
  au FileType go setl sw=8 sts=8 sw=8 et!

  " return to last position after reopen
  au BufReadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup END


" =================================
" Plugin config
" =================================


" =================================
" syntastic
" =================================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" =================================


" =================================
" vimspector
" =================================
let g:vimspector_enable_mappings = 'HUMAN'
noremap <Leader>vr :VimspectorReset<CR>


" =================================
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
" let g:airline_extensions = []
" =================================


" =================================
" Rainbow Parentheses Autoload
" =================================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" =================================


" =================================
" LSP
" =================================
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'allowlist': ['python'],
"         \ })
if executable('jedi-language-server')
     au User lsp_setup call lsp#register_server({
         \ 'name': 'jedi-language-sever',
         \ 'cmd': {server_info->['jedi-language-server']},
         \ 'allowlist': ['python'],
         \ })
endif

function! s:on_lsp_buffer_enabled() abort
    " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <Leader>gd <plug>(lsp-definition)
    nmap <buffer> <Leader>rn <plug>(lsp-rename)
    nmap <buffer> <Leader>ca <plug>(lsp-code-action)
    nmap <buffer> <Leader>gpd <plug>(lsp-peek-definition)
    nmap <buffer> <Leader>r <plug>(lsp-references)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:lsp_diagnostics_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
" =================================


" =================================
" buffers with CtrpP
" =================================
noremap <Leader>b :CtrlPBuffer<CR>
noremap <Leader>. :CtrlPTag<CR>
let g:webdevicons_enable_ctrlp = 1
" =================================
" CtrlP lsp
" =================================
noremap <Leader>ds :CtrlPLspDocumentSymbol<cr>
noremap <Leader>ws :CtrlPLspWorkspaceSymbol<cr>
" =================================


" =================================
" undotree
" =================================
nnoremap <Leader>u :UndotreeToggle<cr>
" =================================
