set nocompatible

filetype off

" Mute bell
set visualbell
set t_vb=

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " make vundle work
" ----- python code folding ---------------------
Plugin 'Konfekt/FastFold'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim' " Hopefully gets python indents right

" ----- LaTeX -----------------------------------
Plugin 'lervag/vimtex'

" ---- Make Vim look good -----------------------

Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"---- filetree, syntax, tags ---------------------
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-syntastic/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim' " not working?
Plugin 'vim-scripts/a.vim' " open header files automatically
Plugin 'Valloric/YouCompleteMe' " syntax completion

" ---- work with Git ---------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" ---- finish brackets etc. --------------------
Plugin 'Raimondi/delimitMate'

" ----- man pages, tmux ------------------------
Plugin 'jez/vim-superman'
Plugin 'christoomey/vim-tmux-navigator'

" ----- other ---------------------------------
" Highlight and strip trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" Align CSV files at commas, align Markdown tables, and more
Plugin 'godlygeek/tabular'

call vundle#end()

filetype plugin indent on

" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

syntax on

set mouse=a

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" ----- Plugin-Specific Settings -----------------

" ----- alteration/vim-colors-solarized settings -

set background=dark

" Uncomment the next line if your terminal is not configured for solarized
let g:solarized_termcolors=256

" Set the colorscheme
colorscheme solarized


" ----- bling/vim-airline settings --------------
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1
"
" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
"
" Use the solarized theme for the Airline status bar
let g:airline_theme='solarized'

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
 nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
 let g:nerdtree_tabs_open_on_console_startup = 1

" ----- scrooloose/syntastic settings -----
"let g:syntastic_error_symbol = '✘'
"let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
	au!
	au FileType tex let b:syntastic_mode = "passive"
augroup END

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
au!
	au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
	au FileType tex let b:delimitMate_quotes = ""
	au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
	au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- jez/vim-superman settings -----
" better man page support
noremap K :SuperMan <cword><CR>

nmap <F5> <Esc>:w<CR>:ter python3 -m %:r<CR>

" tab settings for python
au FileType python
	\ setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

" virtual environment support
python3 << EOF
import os, sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

" LaTeX support
syntax enable
let g:vimtex_view_method = 'zathura' " pdf viewer
autocmd VimEnter *.tex VimtexCompile " compiles on start
let lmaplocalleader = "," " keybindings
set spell spelllang=en_gb
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
