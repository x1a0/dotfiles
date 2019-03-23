let g:mapleader = "\<space>"

call plug#begin('~/.vim/plugged')

Plug 'bitc/vim-bad-whitespace'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
" {{{
let g:rustfmt_autosave = 1
" }}}
Plug 'racer-rust/vim-racer'
" {{{
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
au FileType rust nmap <leader>jd <Plug>(rust-def-split)
" }}}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" {{{
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif
" }}}
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
nnoremap <silent> <leader><space> :Files<CR>
" }}}
Plug 'ervandew/supertab'
" {{{
let g:SuperTabDefaultCompletionType = "context"
" }}}
Plug 'neomake/neomake'
" {{{
let g:neomake_open_list = 2
" }}}

call plug#end()

" {{{ for neomake (has to be after indicating plug#end())
call neomake#configure#automake('nrwi', 500)
" }}}

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
