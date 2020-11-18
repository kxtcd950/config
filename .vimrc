let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set t_ut=

set nocompatible              " be iMproved, required
filetype off                  " required

" Plugin use:
" fzf & fzf.vim: rarely.
" vim-fugitive: should be used more
" vim-umimpaired: rarely
" vim-commentary: rarely
" vim-sensible: all the time
" luochen1990/rainbow: all the time
" altercation/vim-colors-solarized: all the time
" octol/vim-cpp-enhanced-highlight: all the time
" haya14busa/incsearch.vim: all the time
" neoclide/coc.vim: practically constantly
" rhysd/vim-clang-format: practically constantly

"call plug#begin('~/.vim/plugged')
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-sensible'
"Plug 'luochen1990/rainbow'
""vim-colors-solarized requires a symlink to ~/.vim/colors/solarized.vim to be created to work.
""Plug 'altercation/vim-colors-solarized', { 'do': 'ln -s ~/.vim/plugged/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim' }
"Plug 'lifepillar/vim-solarized8'
"Plug 'haya14busa/incsearch.vim'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'rhysd/vim-clang-format'
"Plug 'machakann/vim-sandwich'
"call plug#end()

set autoread
set ts=3 sw=3
set showmatch
syntax on
set smarttab
set shiftwidth=3
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
filetype indent on
set expandtab
set encoding=utf8
set nobackup
set nowb
set noswapfile
set lbr
set tw=128
set ai
set si
set wildmenu
set hidden
set is
set hls
" for coc.vim
set cmdheight=2
set updatetime=300

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

if has("gui_running")
   " Set the font to be something pleasant for each windowing system I use.
   if has("gui_win32")
      set guifont=Deja\ Vu\ Sans\ Mono\ for\ Powerline:h12
   endif
   if has("gui_gtk")
      set guifont=Deja\ Vu\ Sans\ Mono\ for\ Powerline\ 12
   endif
   " remove menu, toolbar and scrollbars by not specifying any of mlrbT
   set guioptions=
endif

let mapleader="\\"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


"map <leader>te :tabedit <c-r>=expand(%:p:h)<cr>/

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    au BufWritePre *.go,*.txt,*.js,*.py,*.wiki,*.sh,*.c,*.h,*.cpp,*.hpp : call CleanExtraSpaces()
    au BufReadPost * if line("'\"") > 1 && line ("'\"") <=line("$") | exe "normal! g'\"" | endif
    au FileType yaml setlocal shiftwidth=2 tabstop=2
    au FileType py setlocal shiftwidth=4 tabstop=4
    augroup automaticallySourceVimrc
        au!
        au bufwritepost .vimrc source ~/.vimrc
    augroup END
    au FileType c,cpp ClangFormatAutoEnable
endif

nnoremap <leader>ev :tabe ~/.vimrc<CR>

let g:rainbow_active=1
let g:rg_window_location='none'
nmap <leader>td O// TODO(dave) - <ESC>A
nnoremap <leader>rg :Rg 
nnoremap <leader>bn :bNext<CR>
nnoremap <leader>bp :bPrev<CR>
nnoremap <leader>cf :<C-u>ClangFormat<CR>
vnoremap <leader>cf :ClangFormat<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>P :CtrlPBuffer<CR>

nnoremap <leader><F5> :let &colorcolumn=120-&colorcolumn<CR>
inoremap <leader><F5> <ESC>:let &colorcolumn=120-&colorcolumn<CR>i
set termguicolors

set background=dark
" set solarized_termtrans=1
colorscheme solarized8

if executable("rg")
   set grepprg=rg\ --vimgrep\ --no-heading
   set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set nomodeline

" Make Coc.nvim's warnings actually readable
hi CocWarningSign ctermfg=Blue guifg=Yellow ctermbg=Black guibg=Black
hi CocErrorSign guifg=Red guibg=Black
hi CocInfoSign guifg=Blue guibg=Black

set wildignore+=tags,Setup*for*.txt,*/tests/*,*/testing/*

let g:ctrlp_custom_ignore = {
   \ 'dir': '.git',
   \ 'file': 'NO_IGNORE_FILES',
   \ 'link': 'NO_SYMBOLIC_LINKS',
   \ }
