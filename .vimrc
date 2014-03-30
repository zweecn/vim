" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" ==========================================================================
" 以下是vi的基本设置
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
if has("syntax")
  syntax on
endif
set backspace=indent,eol,start
set nocompatible
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set fileformats=unix
set shiftwidth=4
set tabstop=4
set showcmd
set showmatch
set autoindent
set cindent
set smartindent
set ruler
set number
if has("vms")
	set nobackup
else
	set backup
	set backupdir=~/.backup,/tmp "备份目录
endif
set incsearch
set hlsearch

let curpwd = getcwd()
" vim自身命令行模式智能补全
set wildmenu

" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 定义快捷键 跳转到当前行的行首
" nmap lg 0
" 定义快捷键 跳转到当前行的行尾
" nmap le $
" 定义快捷键 关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键 保持当前窗口内容
nmap <Leader>w :w<CR>
" 设置快捷键 将选中文本块复制至系统剪贴板 系统剪贴板是+
vnoremap <Leader>y "+y
" 设置快捷键 将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p
" 设置快捷键 进行工程编译及链接，并同时在quickfix输出make结果
" 前提是工程目录中有Makefile文件
nmap <Leader>m :wa<CR>:make<CR>:bot cw<CR><CR>

" 定义快捷键 跳转到光标所在关键词的定义处
nmap <Leader>gt <C-]>
" 定义快捷键 跳回原关键词 与 ;gr 配合使用
nmap <Leader>gr <C-T>
" 定义快捷键 跳到当前屏幕倒数第二行
nmap <Leader>gf <C-f>
" 定义快捷键 跳到当前屏幕第二行
nmap <Leader>gb <C-b>
"快速切换C H源文件
nmap <Leader>cd :A<CR>
" 使用Grep.vim插件在工程内全局查找，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :Grep<CR>
" 设置快捷键gs遍历各分割窗口。快捷键速记法：goto the next spilt window
nnoremap <Leader>gs <C-W><C-W>

"==========================================================================
" 以下是设置自动应用模板,并插入时间
if has("autocmd")
  " 自动检测文件类型并加载相应的设置
  " Python 文件的一般设置，比如不要 tab 等
  autocmd FileType python setlocal et | setlocal sta | setlocal sw=4

  " Python Unittest 的一些设置
  " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
  " 键入 :make 或者点击 gvim 工具条上的 make 按钮就自动执行测试用例
  autocmd FileType python compiler pyunit
  autocmd FileType python setlocal makeprg=python\ ./alltests.py
  autocmd BufNewFile,BufRead test*.py setlocal makeprg=python\ %

  " 自动使用新文件模板
  autocmd BufNewFile test*.py 0r ~/.vim/skeleton/test.py
  autocmd BufNewFile alltests.py 0r ~/.vim/skeleton/alltests.py
  autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py
 " 自动应用C模板 
  autocmd BufNewFile *.c 0r ~/.vim/skeleton/model.c
  autocmd BufNewFile *.cpp 0r ~/.vim/skeleton/model.cpp
  autocmd BufNewFile *.java 0r ~/.vim/skeleton/model.java
  autocmd BufNewFile *.h 0r ~/.vim/skeleton/model.h
  " python自动补全
  autocmd FileType python set complete+=k~/.vim/tools/pydiction.py 
endif
" """"""""""""""""""""""""""
" " 插入系统日期
" """"""""""""""""""""""""""
" map <F5> :r !date +\%c<CR>
" " 函数，修改文件头部的最后修改时间，就象这个文件的头部一样
" function! LastMod()
"   if line("$") > 10
"     let l = 10
"   else
"     let l = line("$")
"   endif
"   exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
" endfunction
" 
" " 手工更新文件最后修改时间
" map ,L :call LastMod()<CR>
" 
" " Edit "Last modified"-comment in the top 5 lines of config files
" " 自动更新文件修改时间
" if has("autocmd")
"   augroup lastmod
"     autocmd!
"     autocmd BufWritePre,FileWritePre * exec("normal ms")|call LastMod()|exec("normal `s")
"   augroup END
" endif
" "==========================================================================
""""""""""""""""""""""""""""""
"以下设置代码折叠
""""""""""""""""""""""""""""""
"set fdm=indent
"==========================================================================
" Tag list (ctags)
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1     "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1   "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1  "在右侧窗口中显示taglist窗口 
let Tlist_WinWidth=20
"=========================================================================
""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
map <silent> <F8> :Sexplore!<cr> 
"=========================================================================
""""""""""""""""""""""""""""""
" WinManager 文件浏览插件
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = 'FileExplorer,BufExplorer|TagList'
let g:persistentBehaviour = 0
let g:winManagerWidth = 30
nmap wm :WMToggle<cr>
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr> 
"=========================================================================
""""""""""""""""""""""""""""""
" Cscope
""""""""""""""""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-
"=========================================================================
"=========================================================================
""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0      " Do not show default help.
let g:bufExplorerShowRelativePath=1 " Show relative paths.
let g:bufExplorerSortBy='mru'       " Sort by most recently used.
let g:bufExplorerSplitRight=0       " Split left.
let g:bufExplorerSplitVertical=1    " Split vertically.
let g:bufExplorerSplitVertSize=30  	" Split width
let g:bufExplorerUseCurrentWindow=0 " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
"=========================================================================
""""""""""""""""""""""""""""""
" 自动补全
""""""""""""""""""""""""""""""
" 关闭兼容模式
set nocp
filetype plugin indent on 
filetype plugin on
filetype on
" 取消补全内容以分割子窗口形式出现，只显示补全列表
set completeopt=longest,menu
" mapping
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>" 
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L> 
"=========================================================================
""""""""""""""""""""""""""""""
" SuperTab
""""""""""""""""""""""""""""""
"cs add $curpwd/cscope.out $curpwd/
let g:SuperTabRetainCompletionType=2
" let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabDefaultCompletionType="<C-X><C-N>"
"=========================================================================
""""""""""""""""""""""""""""""
" NeoComplCache 未设置完成
""""""""""""""""""""""""""""""
"let g:NeoComplCache_EnableAtStartup = 1
"=========================================================================

colorscheme desert 
" colorscheme rainbow_neon 
" colorscheme freya
" colorscheme blackdust

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" >>>>插件相关配置

" 使用NERDTree插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=18
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"

" 设置tagbar子窗口的位置出现在主编辑区的左边
"let tagbar_left=1
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list
"nnoremap <Leader>tl :TagbarToggle<CR>
" 设置标签子窗口的宽度
"let tagbar_width=20

" 定义快捷键 打开/关闭 tag list
nmap tl :TlistToggle<CR>
let Tlist_Auto_Open=0

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" VIM支持多种文本折叠方式，我VIM多用于编码，所以选择符合编程语言语法的代码折叠方式。
set foldmethod=syntax
" 启动vim时打开所有折叠代码。
set nofen

"F3全工程内搜索匹配字符串
"nnoremap <silent> <F3> :Grep<CR>

"nnoremap <silent> <F3> :A<CR>
let cwd=""
set tags=tags
set tags+=/data/home/waynezheng/.vim/systags
set tags+=/usr/local/taf/include/TAGS
set tags+=/data/home/waynezheng/Server/tags
cs add /data/home/waynezheng/.vim/cscope.out 
cs add /data/home/waynezheng/cscope/GameCenter_dev/cscope.out /home/waynezheng/GameCenter_dev

let g:miniBufExplMapWindowNavArrows = 1
"允许光标在任何位置时用CTRL-TAB遍历buffer
let g:miniBufExplMapCTabSwitchBufs = 1

" 重新打开文档时光标回到文档关闭前的位置
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \ exe "normal g'\"" |
                \ endif
endif

