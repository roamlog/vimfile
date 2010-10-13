" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
"
" roamlog 的 VIM 配置文件
"
"   author: roamlog<roamlog@gmail.com>
"  website: http://roamlog.info
"     date: 2010-10-13

if v:version < 700
  echoerr 'This _vimrc requires Vim 7 or later.'
  quit
endif

" 获得当前目录
function! CurrectDir()
	return substitute(getcwd(), "", "", "g")
endfunction

" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
  let l:c = 0
  while l:c<line("$") && (
        \ getline(l:c) =~ '^\s*$'
        \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
        \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
        \ )
    let l:c = l:c+1
  endwhile
  exe "normal ".l:c."Gz\<CR>"
endf

" 返回当前时间
func! GetTimeInfo()
    return strftime('%Y-%m-%d %A %H:%M:%S')
endfunction

" 全选
func! SelectAll()
    let s:current = line('.')
    exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endfunc

" From an idea by Michael Naumann
func! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunc

" =========
" 环境配置
" =========
" 保留历史记录
set history=400

" 行控制
set nocompatible  "不兼容 vi
set whichwrap+=<,>,h,l "光标移动
set textwidth=80 "自动换行

" 标签页
set tabpagemax=8
set showtabline=2

" 控制台响铃
set noerrorbells
set novisualbell
set t_vb= "close visual bell

" 修改 leader 键的快捷键
let mapleader = ","

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" 命令行于状态行
set ch=1
set statusline=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ %=\ [Line]%l/%L\ %=\[%P]
set ls=2 " 始终显示状态行

" 搜索
set hlsearch
set showmatch
set mat=2
set incsearch

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

" 相对行号
"set relativenumber

" 撤销
set undofile

" 缩进
set autoindent
set smartindent

" 自动重新读入
set autoread

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

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

" 自动格式化
set formatoptions=tcrqn

" 去除工具栏
set go-=T

" 用空格键来开关折叠
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 启用 pathogen.vim 插件
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on
    
    " 括号自动补全
    func! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    " save on losing focus
    au FocusLost * :wa
    
    " make ; do the same thing as :
    nnoremap ; :

    " strip all trailing whitespace in the current file
    nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

    "clear search
    nnoremap <leader><space> :noh<cr>

    " fold tag
    nnoremap <leader>ft Vatzf

    " reselect the text that was just pasted
    nnoremap <leader>v V`]

    " quickly open up my vimrc file
    nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

    " return to normal mode by jj
    inoremap jj <ESC>
    
    " split windows
    nnoremap <leader>w <C-w>v<C-w>l

    " move around from splits
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    
    "auto close for PHP and Javascript script
    au FileType php,c,python,java,javascript exe AutoClose()

    " Auto Check Syntax
    au BufWritePost,FileWritePost *.js,*.php call CheckSyntax(1)

    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1

    " 格式化 JavaScript 文件
    "au FileType javascript map <f12> :call g:Jsbeautify()<cr>
    nnoremap <silent> <leader>js :call g:Jsbeautify()<cr>
    
    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    
    " 增加 ActionScript 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.as setf actionscript 

    " 增加 Objective-C 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.m,*.h setf objc
    
    " 给各语言文件添加 Dict
    if has('win32')
        au FileType php setlocal dict+=$VIM/vimfiles/dict/php_funclist.dict
        au FileType css setlocal dict+=$VIM/vimfiles/dict/css.dict
        au FileType javascript setlocal dict+=$VIM/vimfiles/dict/javascript.dict
    else
        au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
        au FileType css setlocal dict+=~/.vim/dict/css.dict
        au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
    endif

    " 自动最大化窗口
    if has('gui_running')
        if has("win32")
            au GUIEnter * simalt ~x
        "elseif has("unix")
            "au GUIEnter * winpos 0 0
            "set lines=999 columns=999
        endif
    endif
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
    colorscheme slate

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
endif

" =========
" 快捷键
" =========

" 标签相关的快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabnew <cr>
map te :tabedit
map tc :tabclose<cr>

" 插件快捷键
nmap ,n :NERDTree<CR>
nmap bf :BufExplorer<cr>

" 开启 hypergit.vim 
nmap <leader>g :ToggleGitMenu<cr>

" 新建 XHTML 、PHP、Javascript 文件的快捷键
nmap <C-c><C-h> :NewQuickTemplateTab xhtml<cr>
nmap <C-c><C-p> :NewQuickTemplateTab php<cr>
nmap <C-c><C-j> :NewQuickTemplateTab javascript<cr>
nmap <C-c><C-c> :NewQuickTemplateTab css<cr>
nmap <Leader>ca :Calendar<cr>

" 直接看代码
nmap <C-c><C-f> :call GotoFirstEffectiveLine()<cr>
            
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

" 插入模式按 Ctrl + D(ate) 插入当前时间
imap <f2> <C-r>=GetTimeInfo()<cr>

" 让命令行模式下也能使用 bash 的一些快捷键
cmap <c-a> <home>
cmap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-f> <right>
cnoremap <c-n> <down>
cnoremap <c-p> <up>

cnoremap <esc><c-b> <s-left>
cnoremap <esc><c-f> <s-right>

" 映射光标控制
imap <M-h> <Left>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-l> <Right>

" 开关 tags 窗口
map <M-t> :TlistToggle<CR>
imap <M-t> <Esc><A-t>i

"用c-q一个快捷键切换窗口及把窗口扩大
map <C-W> <C-w>_
nnoremap <C-Tab> <C-W>W
inoremap <C-Tab> <C-O><C-W>W

" =========
" 插件
" =========
" Javascript in CheckSyntax
if has('win32')
    let g:checksyntax_cmd_javascript  = 'jsl -conf '.shellescape($VIM . '\vimfiles\plugin\jsl.conf')
else
    let g:checksyntax_cmd_javascript  = 'jsl -conf ~/.vim/plugin/jsl.conf'
endif
let g:checksyntax_cmd_javascript .= ' -nofilelisting -nocontext -nosummary -nologo -process'

" js lint检验
autocmd FileType Javascript nmap <F3> :call JavascriptLint()<cr>

" html, css校验
autocmd FileType html,xhtml,css nmap <F3> :make<cr><cr>:copen<cr>

" 自动完成设置 禁止在插入模式移动的时候出现 Complete 提示
let g:acp_completeOption='.,w,b,u,t,i,k'
let g:acp_mappingDriven = 1
let g:acp_behaviorSnipmateLength = 1

compiler ruby         " Enable compiler support for ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
set guitablabel=%t

" VimWiki 配置
let g:vimwiki_list = [{"path": "~/Wiki/", "path_html": "~/Sites/wiki/", "auto_export": 1}]
let g:vimwiki_auto_checkbox = 0
if has('win32')
    let g:vimwiki_list = [{"path": "d:/Documents/My Dropbox/Vimwiki/", 
        \ "path_html": "D:/Documents/My Dropbox/Vimwiki/public_html", "auto_export": 1}]
    let g:vimwiki_w32_dir_enc = 'cp936'
endif
nmap <C-i><C-i> :VimwikiTabGoHome<cr>

" ===========
" 其它
" ===========

"修改 vmirc 后自动生效
autocmd! bufwritepost .vimrc source ~/.vimrc

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

"输入,e命令时,后面跟上当前目录结果
if has("unix")
	map ,e :e <C-R>=expand("\%:p:h") . "/" <CR>
else
	map ,e :e <C-R>=expand("\%:p:h") . "\\" <CR>
endif
	
"输入,c命令时,后面跟上当前目录结果
if has("unix")
	map ,c :cd <C-R>=expand("\%:p:h") . "/" <CR>
else
	map ,c :cd <C-R>=expand("\%:p:h") . "\\" <CR>
endif
