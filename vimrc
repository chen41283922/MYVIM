set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'

"Plugin 'octol/vim-cpp-enhanced-highlight'




call vundle#end()            " required


filetype plugin indent on    " required



"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ



" Set foldmethod=marker {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}



" Set leader key to Space bar,  local leader key to comma
let mapleader = "\<Space>"
let maplocalleader = ","


cnoremap nd NERDTree<Cr>


augroup Filetype_comment
    autocmd!
    " Add comment
    autocmd FileType cpp,c nnoremap <buffer> <localleader>cc I//<esc>
    autocmd FileType vim   nnoremap <buffer> <localleader>cc I"<esc>
    " Remove comment
    autocmd FileType cpp,c nnoremap <buffer> <localleader>cd ^xx
    autocmd FileType vim   nnoremap <buffer> <localleader>cd ^x


    "autocmd FileType cpp,c nnoremap <buffer> <localleader>cf I//<esc>
augroup END

" Add ; in cpp and c file at the end of line
augroup Filetype_Addsemicolon
    autocmd!
    autocmd FileType cpp,c   nnoremap <buffer> <localleader>; A;<esc>
augroup END






" Transform cword to uppercase or lowercase
nnoremap <leader>u viwu<Esc>
nnoremap <leader>U viw<S-u><Esc>

" surround the cword in certain character 
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel


" move to next or previous {/}, add this map in case of {/} not in the first
" column
nnoremap [[ ?{<CR>w99[{:noh<Esc>
nnoremap ][ /}<CR>b99]}:noh<Esc>
nnoremap ]] j0[[%/{<CR>:noh<Esc>
nnoremap [] k$][%?}<CR>:noh<Esc>



""vnoremap [[ :<C-U>?{<CR>w99[{:noh<Esc>
""vnoremap ][ :<C-U>/}<CR>b99]}:noh<Esc>
""vnoremap ]] :<C-U>j0[[%/{<CR>:noh<Esc>
""vnoremap [] :<C-U>k$][%?}<CR>:noh<Esc>




" Insert new line in normal mode by press Enter 
"
nnoremap <CR> o<ESC>

" Insert new line upon in normal mode by press Ctrl+Enter
nnoremap <leader><CR> O<ESC>j

set pastetoggle=<F3>


iabbrev loacl local

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
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

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
set statusline=%1*\ %{toupper(g:currentmode[mode()])}\ 
set statusline+=%2*\ %{expand('%:p')}\ 
set statusline+=%3*\ [
set statusline+=%{strlen(&fileencoding)?&fileencoding:&encoding}
set statusline+=,\  
set statusline+=%{&fileformat}
set statusline+=,\  
set statusline+=%{strlen(&filetype)?&filetype:'plain'}
set statusline+=]
set statusline+=%{FileSize()}%{IsBinary()}
set statusline+=%=
set statusline+=%1*\ %c,%l/%L\ 
set statusline+=\  
set statusline+=[%3p%%]

"set statusline=



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

" statusline mode highlight config
highlight User1 ctermfg=0 ctermbg=75 
au InsertEnter * hi User1  ctermfg=0 ctermbg=226
au InsertLeave * hi User1 ctermfg=0 ctermbg=75
" FilePath highlight config
highlight User2 ctermfg=231 ctermbg=239

" Format highlight config
highlight User3 ctermfg=0 ctermbg=249



let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

