set nocompatible              " be iMproved, required
""filetype off                  " required
""
"""set the runtime path to include Vundle and initialize
""set rtp+=~/.vim/bundle/Vundle.vim
""call vundle#begin()
""
""Plugin 'VundleVim/Vundle.vim'
""Plugin 'octol/vim-cpp-enhanced-highlight'
""
""" All of your Plugins must be added before the following line
""call vundle#end()            " required
""""filetype plugin indent on    " required
"""
""" Brief help
""" :PluginList       - lists configured plugins
""" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
""" :PluginSearch foo - searches for foo; append `!` to refresh local cache
""" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"""
""" see :h vundle for more details or wiki for FAQ
""" Put your non-Plugin stuff after this line"

""set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,~/.vim/after/syntax,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after

" Set foldmethod=marker {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}



"{{{
" Wrap the word under the cursor with "
"nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" }}}



let mapleader = "\<Space>"
set backspace=2
filetype on
set nu
set relativenumber

set hlsearch
set incsearch

set t_co=256
set cindent

set softtabstop=4
set shiftwidth=4

set cursorline
hi CursorLine cterm=none ctermbg=5 ctermfg=none	


"Line Number Color Config"
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE


" Customized Key Mapping
inoremap {<CR> {<CR>}<Esc>ko
""inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
""inoremap " ""<Esc>i
""inoremap ' ''<Esc>i

" Quick way to Normal mode
inoremap jk <esc>


" Turn off hlsearch hint
nnoremap <silent><leader>h  :noh<CR>


" Turn on .vimrc file in vertical windows
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Source .vimrc without closing file
nnoremap <leader>sv :source $MYVIMRC<cr>



" Ctags tags file path
set tags=./tags,./TAGS,tags;~,TAGS;~

" Ctags open tags in new tab
nnoremap <C-]> <C-w><C-]><C-w>T

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0 " if you are in empty line 
            return "\"_ddko" " delete the current line and move to previous line, add new line
    else
            return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

set laststatus=2
" Modify statusline 
set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]

function! IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
	return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction


