"Load Pathogen and all bundles
source ~/.vim/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"Basic goodness
syntax on
filetype plugin indent on
set number
set mouse=a

"Solarized color scheme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized
