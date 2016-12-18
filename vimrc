" ========================================================================
" Vundle
" ========================================================================
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Bundles
Plugin 'altercation/vim-colors-solarized'
Plugin 'davidhalter/jedi-vim'
Plugin 'fatih/vim-go'
Plugin 'kien/ctrlp.vim'
Plugin 'moll/vim-node'
Plugin 'othree/javascript-libraries-syntax.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" =======================================================================

syntax enable
set background=dark
colorscheme solarized

set number
set autoindent

let mapleader = ','

set pastetoggle=<F2>
set clipboard=unnamedplus

set t_Co=256

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

set mouse=a
" nicer buffer handling
set hidden

" tabs vs spaces
" golang
au FileType python setl sw=8 sts=8 sw=8 et!

" Set the tag file search order
set tags=./tags;

set laststatus=2


" plugin dependent settings
" close preview bugger with docs when autocompleting
autocmd CompleteDone * pclose

" =================================

let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

let g:used_javascript_libs = 'angularjs, jquery'

" turn on NERDTree
nmap <silent> <leader>nt :NERDTreeToggle<CR>

" buffers with CtrpP
nnoremap <Leader>b :CtrlPBuffer<CR>


" ================================
" Remapping
" ================================

" Leader mappings
nnoremap <Leader>en :set spell spelllang=en<CR>
nnoremap <Leader>sk :set spell spelllang=sk<CR>

map <Leader>t <esc>:tabnew<CR>
map <Leader>x <C-w>c

noremap <Leader>l <esc>:nohl<CR>
vnoremap <Leader>l <esc>:nohl<CR>
inoremap <Leader>l <esc>:nohl<CR>


" sort the selection
vnoremap <Leader>s :sort<CR>



" better command line edditing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ================================

" exit insert mode, prevent one char left
imap jk <Esc>`^

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

" ====================================

" spell check style
hi clear Spellbad
hi SpellBad cterm=underline ctermfg=red

" return to last position after reopen
if has("autocmd")
  au BufReadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
