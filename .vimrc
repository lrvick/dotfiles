"Load Pathogen and all bundles
source ~/.vim/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"Basic goodness
syntax on
filetype plugin indent on
set number
set mouse=a
set cursorline
set autoindent smartindent

"Solarized color scheme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

"Language Specific Tweaks
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=79

"Custom indent-guides config
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=236
hi IndentGuidesEven ctermbg=233
