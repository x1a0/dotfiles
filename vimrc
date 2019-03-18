let g:mapleader = "\<space>"

call plug#begin('~/.vim/plugged')
Plug 'bitc/vim-bad-whitespace'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" {{{
    let g:racer_experimental_completer = 1
    let g:racer_insert_paren = 1
" }}}
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
    nnoremap <silent> <leader><space> :Files<CR>
" }}}
call plug#end()

set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set expandtab
set showcmd
set number
set showmatch
set ignorecase
set smartcase
set ruler
set background=dark
set hidden

set completeopt=longest,menuone
inoremap <tab> <C-x><C-o>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap jk <ESC>
nmap <Leader>q :q<CR>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal
let base16colorspace=256
try
  colorscheme base16-default-dark
catch /^Vim\%((\a\+)\)\=:E185/
  " color scheme not installed yet
endtry

" tab switch
nnoremap <S-h> gT
nnoremap <S-l> gt

set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

"" Fugitive
nmap <Leader>gs :Gstatus<CR><C-w>_<C-n>
nmap <Leader>gci :Gcommit<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gb :Gblame<CR>

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

nmap <Leader>j :%!python -m json.tool<CR>
