""" Turn off Vi mode
set nocompatible

""" =========== VUNDLE ========================================================
filetype off

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
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'udalov/kotlin-vim'
Plugin 'Vimjas/vim-python-pep8-indent'
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
"                     :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"                     auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""" ===========================================================================

""" Turn on syntax highlighting
syntax on

""" Expand tabs
set shiftwidth=4
set softtabstop=4
set expandtab
    
""" Smart indentation
set smartindent
"au! FileType python setl nosmartindent
"au! FileType python setl autoindent

""" Remove trailing whitespace
autocmd BufWritePre *.pl,*.py,*.kt,*.java %s/\s\+$//e

""" Colours
colorscheme darth

""" Wrap text at 80ish chars.
set textwidth=79

"set comments=s1:/**,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set formatoptions=tcqr

""" Set line numbers on by default
set number
set relativenumber
