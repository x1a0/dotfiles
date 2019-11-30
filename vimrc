let g:mapleader = "\<space>"

call plug#begin('~/.vim/plugged')

Plug 'bitc/vim-bad-whitespace'

Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-fugitive'
" {{{
nmap <Leader>gs :Gstatus<CR><C-w>_<C-n>
nmap <Leader>gci :Gcommit<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gb :Gblame<CR>
" }}}

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" {{{
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
nnoremap <F3> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> rd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

if has('nvim')
	Plug 'Shougo/deoplete.nvim', {
		\ 'do': ':UpdateRemotePlugins',
		\ }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
" {{{ enable Python3 interface: `pip3 install --user pynvim`
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
" }}}
"
Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" {{{
nnoremap <silent> <leader><space> :Files<CR>
" }}}

Plug 'neomake/neomake'
" {{{
let g:neomake_open_list = 2
" }}}

Plug 'hashivim/vim-terraform'

call plug#end()

" {{{ for neomake (has to be after indicating plug#end())
call neomake#configure#automake('nrwi', 500)
" }}}

set encoding=utf-8
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

set exrc
set secure

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap jk <ESC>
nmap <leader>q :q<CR>

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

" terraform
autocmd FileType tf setlocal shiftwidth=2 softtabstop=2 expandtab

" vim yaml crosshair
hi CursorLine   cterm=NONE
hi CursorColumn cterm=NONE
autocmd Filetype yaml :set tabstop=2 shiftwidth=2 expandtab cursorline! cursorcolumn!
autocmd Filetype tf   :set tabstop=2 shiftwidth=2 expandtab cursorline! cursorcolumn!
