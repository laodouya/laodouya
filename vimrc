set shell=/bin/bash

set nocompatible
filetype off    " required

" set the runtime path to include Vundle and initialize
" first run: git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
"Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"NerdTree
let NERDTreeChDirMode=2
let NERDTreeDirArrows=0 "目录箭头 1 显示箭头  0传统+-|号

function! ToggleNERDTree(stats)
    let w:jumpbacktohere = 1

    "Detect if open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif

    "open NERDTree
    if nerdtree_open
        if 'toggle'==a:stats
            NERDTreeClose
        endif
    else
        NERDTree
    endif

    "Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction

function! ToggleTagbar(stats)
    let w:jumpbacktohere = 1

    "Detect if open
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    "open Tagbar
    if tagbar_open
        if 'toggle'==a:stats
            TagbarClose
        endif
    else
        TagbarOpen
    endif

    "Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction

function! ToggleNERDTreeAndTagbar(stats)
    let w:jumpbacktohere = 1

    "Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    "open NERDTree and Tagbar
    if nerdtree_open && tagbar_open
        if 'toggle'==a:stats
            NERDTreeClose
            TagbarClose
        endif
    elseif nerdtree_open
        TagbarOpen
    elseif tagbar_open
        NERDTree
    else
        NERDTree
        TagbarOpen
    endif

    "Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction

map <F6> :call ToggleNERDTree('toggle')<CR>
map <F7> :call ToggleTagbar('toggle')<CR>
map <F8> :call ToggleNERDTreeAndTagbar('toggle')<CR>

"switch paste mode
set pastetoggle=<F9>

"auto toggle NerdTree and Tagbar when open specified filetype
au FileType cpp,c,h call ToggleNERDTreeAndTagbar('open')
"au FileType go call ToggleNERDTree('open')

"close nerdtree when :q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"replace Ctrl+w+j with Ctrl+j. For change windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l
vnoremap <C-h> <C-W>h
vnoremap <C-j> <C-W>j
vnoremap <C-k> <C-W>k
vnoremap <C-l> <C-W>l

"mouse right click
if has('mouse')
    set mouse-=a
endif

"set tab
set expandtab
set ts=4
set sw=4
set sts=4
set tw=100

set backspace=indent,eol,start

"set ctags file
set tags=tags;
set autochdir

"auto reload file
set autoread

"highlight search result
set hlsearch

"display line number
set nu

set ruler

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
syntax enable
set background=dark
"colorscheme solarized

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set autowriteall
"set hidden             " Hide buffers when they are abandoned

"Enable file type detection.
filetype plugin indent on

"set auto indent
set autoindent
set smartindent
set cindent

"set no backups
set nobackup
set nowritebackup

"set no auto change line
set nowrap

"set encodings for chinese
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


"YouCompleteMe config
let mapleader = ","  "这个leader就映射为逗号“，”
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'   "配置默认的ycm_extra_conf.py
"按,d 会跳转到定义
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_confirm_extra_conf=0    "打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件


augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"go setting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 1
"let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
