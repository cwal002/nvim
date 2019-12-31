"==========首次使用自动加载===========
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"=====================================
set helplang=cn "设置中文帮助
set history=500 "保留历史记录
set backspace=2 "设置退格键可用
 " 开启语法高亮功能
syntax enable
syntax on
set number
set relativenumber
set cursorline "下划线
set cursorcolumn "高亮显示列"
set wrap
set showcmd
set wildmenu "命令补全
set hlsearch "高亮搜索
exec "nohlsearch"
set incsearch "实时搜索高亮
set ignorecase "搜索忽略大小写
set smartcase
let mapleader=" "
"set clipboard=unnamed "设置剪切办
highlight clear LineNr

noremap J 5j
noremap K 5k
noremap <LEADER><CR> :nohlsearch<CR>
set showmatch "显示匹配的括号

set autoindent
set cindent
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldlevel=99
""set cursorline " 高亮当前行
""set paste " 为粘贴到vim的代码保持格式

set foldenable " 允许折叠
set foldmethod=manual " 手动折叠
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>


map<up> :res -5<CR>
map<down> :res +5<CR>
map<left> :vertical resize+5<CR>
map<right> :vertical resize-5<CR>


" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

map tt :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>



map <LEADER>l <C-w>l
map <LEADER>h <C-w>h
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!chromium % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc
"====================插件管理================================
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline' "状态栏
Plug 'connorholyday/vim-snazzy' "配色
" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'nathanaelkane/vim-indent-guides' "可视化缩进显示 开关<空格+ig>

" Auto Complete 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"对齐插件 格式符：[对齐方式[此方式后添加的空格数量]]，对齐方式 左l、右r、中c。需要与前面用 / 隔开。
Plug 'godlygeek/tabular'

Plug 'mhinz/vim-startify' "起始页菜单目录
Plug 'jiangmiao/auto-pairs' "括号补全

"代码块
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


"批量注释
Plug 'scrooloose/nerdcommenter' "<空格+cx注释（反注释），空格+cc住，空格+cu取消注释>

"通过类的声明，自动完成类的实现
"Plug 'derekwyatt/vim-protodef'

".h文件与.cpp文件的切换
Plug 'derekwyatt/vim-fswitch'



Plug 'majutsushi/tagbar' "函数列表
call plug#end()

let g:SnazzyTransparent = 1
color snazzy

"===
"===函数列表相关设置tagbar
"===
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=0 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <F8> :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }



"===protodef 设置
" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.config/nvim/plugged/vim-protodef/pullproto.pl'
let g:disable_protodef_sorting=1 "成员函数的实现与声明顺序一致"
 
"===
"===可视化缩进设置vim-indent-guides
"===
let g:indent_guides_enable_on_vim_startup =1 "随vim启动
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2  " 从第二层开始可视化显示缩进
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=4

"
"===
"===fswitch 开关设置 <空格>+sw 
"===
nmap <silent> <Leader>sw :FSHere<CR>





"===
"===代码块设置
"===
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/','Ultisnips']
" 使用 UltiSnipsEdit 命令时垂直分割屏幕
let g:UltiSnipsEditSplit="vertical"


"打开vim时如果没有文件自动打开Startify(起始页)
autocmd vimenter * if !argc()|Startify|
" Open Startify 空格+st打开起始页
noremap <LEADER>st :Startify<CR>

" ===
" === NERDTree 
" ===
map <F2> :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "h"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()" 
" 加入注释 
func SetComment()
	call setline(1,"/*================================================================") 
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call append(line(".")+1, "*   ") 
	call append(line(".")+2, "*   文件名称：".expand("%:t")) 
	call append(line(".")+3, "*   创 建 者：zb")
	call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日")) 
	call append(line(".")+5, "*   描    述：") 
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/") 
	call append(line(".")+8, "")
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(3, "#================================================================") 
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call setline(5, "#   ") 
	call setline(6, "#   文件名称：".expand("%:t")) 
	call setline(7, "#   创 建 者：zb")
	call setline(8, "#   创建日期：".strftime("%Y年%m月%d日")) 
	call setline(9, "#   描    述：") 
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
	call setline(13, "")
endfunc 
" 定义函数SetTitle，自动插入文件头 
func SetTitle()
	if &filetype == 'make' 
		call setline(1,"") 
		call setline(2,"")
		call SetComment_sh()
 
	elseif &filetype == 'sh' 
		call setline(1,"#!/system/bin/sh") 
		call setline(2,"")
		call SetComment_sh()
		
	else
	     call SetComment()
	     if expand("%:e") == 'hpp' 
		  call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H") 
		  call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H") 
		  call append(line(".")+12, "#ifdef __cplusplus") 
		  call append(line(".")+13, "extern \"C\"") 
		  call append(line(".")+14, "{") 
		  call append(line(".")+15, "#endif") 
		  call append(line(".")+16, "") 
		  call append(line(".")+17, "#ifdef __cplusplus") 
		  call append(line(".")+18, "}") 
		  call append(line(".")+19, "#endif") 
		  call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H") 
 
	     elseif expand("%:e") == 'h' 
	  	call append(line(".")+10, "#pragma once") 
	     elseif &filetype == 'c' 
	  	call append(line(".")+10,"#include \"".expand("%:t:r").".h\"") 
	     elseif &filetype == 'cpp' 
	  	    call append(line(".")+10, "#include \"".expand("%:t:r").".h\"") 
            call append(line(".")+11, "#include<iostream>")
            call append(line(".")+12, "using namespace std;")
            call append(line(".")+13, "")
	     endif
	endif
endfunc

