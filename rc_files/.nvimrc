""" Handle Plugins ----------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
"Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'mileszs/ack.vim'
"Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
"Plug 'SirVer/ultisnips'
"Plug 'tpope/vim-fugitive'
"Plug 'vim-airline/vim-airline'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

""" Language Specific Plugins

"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'rhysd/vim-clang-format'
"Plug 'bfrg/vim-cpp-modern', {'on': 'cpp'}
"Plug 'meck/vim-brittany', {'on': 'haskell'}
""" Language Completion / Intelligence Plugins

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug '~/.config/nvim/maninstall_plugins/dbext_2600'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

""" Colour Scheme Plugins

"Plug 'flazz/vim-colorschemes'
"Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'sainnhe/sonokai'
call plug#end()

""" Colour Schemes ----------------------------------------------------
set t_Co=256

"colorscheme panic
"colorscheme onehalfdark
"colorscheme pencil
colorscheme sonokai

set background=dark
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

""" Set up airline ----------------------------------------------------
let g:airline_powerline_fonts = 1

""" Set up indentLine -------------------------------------------------
" https://github.com/Yggdroot/indentLine
let g:indentLine_color_gui = '#53638F'
let g:indentLine_char = '›'

""" -------------------------------------------------------------------

"""Turn off python 2
let g:loaded_python_provider = 0

""" Handle tabs
set expandtab
set tabstop=4
set shiftwidth=4
filetype plugin indent on

" Set the line numbers (and relative number)
set number
"set relativenumber

""" Remove trailing whitespace
autocmd BufWritePre *.cpp,*.h,*.cxx,*.pl,*.py,*.kt,
            \*.java,*.js,*.hs,*.yaml,*.yml
            \ %s/\s\+$//e

""" CTags config, recursively look up parent dirs for tags
set tags=./tags;

""" Set up clang format -----------------------------------------------
let g:clang_format#command = "clang-format-6.0"
let g:clang_format#style_options = {
            \ "Standard" : "C++17",
            \ "BasedOnStyle" : "Google"}
""" -------------------------------------------------------------------
let mapleader = ","

""" Use NERDTree hotkey
nnoremap <leader>ne :NERDTreeFocus<CR>

""" Set up fzf hotkeys
nnoremap <leader>fz :Files<CR>
nnoremap <leader>gz :GFiles<CR>

" Set up yapf hotkey
autocmd FileType python nnoremap <leader>f :0,$!yapf<Cr>

" Set up brittany hotkey
autocmd FileType haskell nnoremap <leader>f :Brittany<Cr>
let g:brittany_on_save = 0

" By default, use the Plug CoC reformat commands with <leader>f
nmap <leader>f  <Plug>(coc-format)

" Set up prettier JS hotkey
autocmd FileType javascript,javascriptreact nnoremap <leader>f :silent %!npx -q prettier --stdin-filepath %<CR>

" Set up clang format hotkeys
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>

""" -------------------------------------------------------------------
" Set up language client


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename function.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Shift tab to accept autocomplete.
inoremap <silent><expr> <S-tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

""" -------------------------------------------------------------------
""" Have better syntax highlighting when curlies in brackets.
let c_no_curly_error = 1

""" -------------------------------------------------------------------
comm! -nargs=? -bang A call CurtineIncSw()

""" -------------------------------------------------------------------
""" NERDTree configuration
" Let NERDtree show hidden files.
let NERDTreeShowHidden=1

""" -------------------------------------------------------------------
" Set up flake8
" By default, flake8 calls are mapped to F7, but this activates it on
" save.
autocmd BufWritePost *.py call flake8#Flake8()


""" Enable Mouse Support ----------------------------------------------
set mouse=a
