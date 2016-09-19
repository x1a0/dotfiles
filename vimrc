call plug#begin('~/.vim/plugged')
Plug 'bitc/vim-bad-whitespace'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
call plug#end()

set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set expandtab
set showcmd
set number
set showmatch
set ignorecase
set smartcase
set ruler
set background=dark

inoremap jk <ESC>
let mapleader=" "
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

"" NERDTree
map <C-n> :NERDTreeToggle<CR>
" find current file
map <Leader>f :NERDTreeFind<cr>

"" Multi cursors
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

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

" Use the_silver_searcher if possible
if executable("ag")
  let g:ackprg='ag --nogroup --nocolor --column'
endif

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
