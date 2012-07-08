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
set fenc=utf-8
set fileencodings=utf-8,ucs-bom,gbk,gb2312,gb18030,cp936
if has("win32")
  set fileencoding=chinese
else
  set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
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
""""""""""""""""""""""""""
" 插入系统日期
""""""""""""""""""""""""""
map <F5> :r !date +\%c<CR>
" 函数，修改文件头部的最后修改时间，就象这个文件的头部一样
function! LastMod()
  if line("$") > 10
    let l = 10
  else
    let l = line("$")
  endif
  exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
endfunction

" 手工更新文件最后修改时间
map ,L :call LastMod()<CR>

" Edit "Last modified"-comment in the top 5 lines of config files
" 自动更新文件修改时间
if has("autocmd")
  augroup lastmod
    autocmd!
    autocmd BufWritePre,FileWritePre * exec("normal ms")|call LastMod()|exec("normal `s")
  augroup END
endif
"==========================================================================
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
filetype plugin indent on 
set nocp " 关闭兼容模式
filetype plugin on
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
let g:SuperTabRetainCompletionType=1
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"=========================================================================
""""""""""""""""""""""""""""""
" NeoComplCache 未设置完成
""""""""""""""""""""""""""""""
"let g:NeoComplCache_EnableAtStartup = 1
"=========================================================================
