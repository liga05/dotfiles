let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
"Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
"Plug 'sheerun/vim-polyglot'
call plug#end()

"set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
"let g:gruvbox_material_background = 'hard'
"colo gruvbox-material

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>
