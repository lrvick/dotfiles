"Load Pathogen and all bundles
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"Basic goodness
syntax on
filetype plugin indent on
set number
set cursorline
set autoindent smartindent

"Enable mouse for selecting/changing windows etc.
set mouse=a

"Highlight end of line whitespace.
set list
set listchars=trail:.

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

"Gundo
nnoremap <F5> :GundoToggle<CR>
