let mapleader ="`"

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

"set bg=dark
colo dracula
let g:dracula_colorterm = 0
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources !xrdb %
