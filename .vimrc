set encoding=utf8      " Set document encoding
set bs=2               " Allow backspacing over everything in insert mode
set autoindent         " Always set auto-indenting on
"The last indent method set overrides all previous
set smartindent        " Automatically indent based on syntax
set smarttab
set softtabstop=4      " How many spaces to use when tab is pressed
set tabstop=4
set shiftwidth=4       " Number of spaces to auto-shift sub-sections of text/code to the right
set expandtab          " We want spaces, not tabs.
set cindent            " c style indenting
set history=1000       " keep 50 lines of command history
set ruler              " Show the cursor position all the time
set nomodeline         " Do not display modeline at bottom of window
set novisualbell       " Do not blink screen on errors or when hitting edge of window
set noerrorbells       " Do not make noise 
set nostartofline      " Do not make cursor go to start of line. Let it say where you put it.
set foldmethod=marker  " Let {{{ and }}} indicate fold points
set viminfo='20,\"500  " Keep a .viminfo file.
set hlsearch           " Highlight all search results
set syntax=Enable      " Enable syntax highlighting
"set spell              " Enable spellchecking
"set spelllang=en_us    " Set spellcheck language
"au BufWritePost * silent !find ./ -name "*.wsgi" -exec touch "{}" \;
"^ screw that lol 
set paste
set showmatch 
filetype plugin on 
let mapleader = ","
set number
colorscheme delek
map ^P :Dpaste<CR>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR> 

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
