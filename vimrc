set shell=/bin/bash

set nocompatible
filetype off    " required

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" On-demand loading
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
" Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

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

map <F10> :GoImports<CR>

"auto toggle NerdTree and Tagbar when open specified filetype
au FileType cpp,c,h,go,py,sh call ToggleNERDTreeAndTagbar('open')
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
set cursorline
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
scriptencoding utf-8
set encoding=utf-8

let g:tagbar_ctags_bin='/opt/homebrew/bin/ctags'

"go highlight setting
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

"go setting
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_autosave = 1

"vim-gitgutter
set updatetime=100

"nerdcommenter
let g:NERDSpaceDelims = 1

" display extra whitespaces
" set list
" set lcs=tab:>-,trail:-,nbsp:-

"YouCompleteMe config
"let mapleader = ','  "这个leader就映射为逗号“，”
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'   "配置默认的ycm_extra_conf.py
""按,d 会跳转到定义
"nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_confirm_extra_conf=0    "打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件

""syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:syntastic_python_python_exec = 'python3'
"let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_pylint_args = '-E'

