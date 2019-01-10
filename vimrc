" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
"
" roamlog 的 VIM 配置文件
"
"   author: roamlog<roamlog@gmail.com>
"  website: http://readful.com
"     date: 2016-06-25

" 获得当前目录
function! CurrectDir()
	return substitute(getcwd(), "", "", "g")
endfunction

" =========
" 环境配置
" =========

" 保留历史记录
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" 修改 leader 键的快捷键
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" 不兼容 vi
set nocompatible

" 控制台响铃
set noerrorbells
set novisualbell
set t_vb= "close visual bell
set mat=2
" 减少刷新和重画
set lz

" set magic on
set magic

" 行号
set number

" 打开状态栏标尺
set ruler 

" 命令行于状态行
set ch=1

"set statusline=\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ \ CWD:\ "%r%{CurrectDir()}%h\ %=\ Line:\ %l/%L

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L

set ls=2 " 始终显示状态行

" 搜索
set hlsearch " 高亮搜索
set showmatch " 显示相对应的括号
set incsearch " 实时搜索

" 默认添加/g
set gdefault

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的指令
set showcmd

" 缩进
set autoindent
set smartindent

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" 自动重新读入
set autoread

" 设定在任何模式下鼠标都可用
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 备份和缓存
set nobackup
set noswapfile
set nowritebackup

" 自动完成
set complete=.,w,b,u,t,i,k
set completeopt=longest,menu

" 代码折叠
set foldmethod=manual

" 保证语法高亮
syntax on

" 中文帮助
set helplang=cn

" 搜索时忽略大小写
set ignorecase
set smartcase

" 当 buff 被丢弃时隐藏它
set bufhidden=hide

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 去除工具栏
set go-=T

" 用空格键来开关折叠
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Add a bit extra margin to the left
set foldcolumn=1

" =====================
" 配置多语言环境
" 默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8

    if has('win32')
        language english
        let &termencoding=&encoding
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =========
" 图形界面
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    if has('gui_macvim')
        set guioptions+=e
    endif

    " 高亮光标所在的行
    set cursorline

    " 编辑器配色
    set background=light
    colorscheme solarized

    if has("gui_macvim")
        set guifont=YaHei\ Consolas\ Hybrid:h16
        set guifontwide=YaHei\ Consolas\ Hybrid:h16
        set confirm

        set lines=28 columns=108
        set macmeta

        let s:lines=&lines
        let s:columns=&columns
        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        " Mac 下，按 \ff 切换全屏
        map <Leader>ff  :call FullScreenToggle()<cr>

        " Set input method off
        set imdisable

        " Set QuickTemplatePath
        let g:QuickTemplatePath = $HOME.'/.vim/templates/'

        " 如果为空文件，则自动设置当前目录为桌面
        lcd ~/Desktop/

        " 自动切换到文件当前目录
        set autochdir
    endif
else
    set background=light
    colorscheme slate
endif

" =========
" 快捷键
" =========

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" 按下 Q 不进入 Ex 模式，而是退出
nmap Q :x<cr

" 使用 tab 及 shift-tab 进行缩排
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv

" 在光标下插入新行
imap <M-o> <Esc>o

" 复制当前行
imap <M-c> <Esc>Ya

" 粘贴到当前行
imap <M-v> <Esc>pi

" 删除当前行重写
imap <M-r> <Esc>ddO

" 删除到行尾
imap <M-u> <Esc>wd$i

" 删除光标处的单词
imap <M-w> <Esc>ebdei

" 映射光标控制
imap <M-h> <Left>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-l> <Right>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

inoremap jj <esc>

" ===========
" 其它
" ===========

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"修改 vmirc 后自动生效
map <leader>s :source ~/.vimrc<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
        colorscheme solarized
    else
        set background=dark
        colorscheme slate
    endif
endfunction

noremap <leader>bg :call ToggleBG()<CR>

" ===========
" 其它
" ===========

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'yegappan/mru'
Plugin 'bufexplorer.zip'
Plugin 'gmarik/sudo-gui.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'mbbill/undotree'

call vundle#end()

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>b :BufExplorer<cr>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'ra' 

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>n :NERDTreeToggle<cr>
map <leader>nt :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>u :UndotreeToggle<cr>
