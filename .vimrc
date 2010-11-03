" {{{ General settings

set encoding=utf8      " Set document encoding
set bs=2               " Allow backspacing over everything in insert mode
set autoindent         " Always set auto-indenting on
set smartindent        " Automatically indent based on syntax
set smarttab           " Automatically insert tabs as appropriate
set tabstop=2          " How many spaces to use when tab is pressed
set shiftwidth=2       " Number of spaces to auto-shift sub-sections of text/code to the right
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
set spell              " Enable spellchecking
set spelllang=en_us    " Set spellcheck language
set hlsearch           " Highlight all search results

" Save/Restore folding views
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" }}}
" {{{ Custom Color Settings

" Highlight Redundant Spaces
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "sets end of match so only spaces highlighted

" Color of folded sections marker line
highlight Folded ctermbg=DarkGrey ctermfg=Black

" }}}
" {{{ Lang Settings 
" Try to come up with some nice sane GUI fonts. Also try to set a sensible
" value for fileencodings based upon locale. These can all be overridden in
" the user vimrc file.
if v:lang =~? "^ko"
  set fileencodings=euc-kr
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~? "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~? "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~? "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default
" }}}
" {{{ Terminal fixes
if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif

if "" == &shell
  if executable("/bin/bash")
    set shell=/bin/bash
  elseif executable("/bin/sh")
    set shell=/bin/sh
  endif
endif

if has("eval")
  let is_bash=1
endif

if &term ==? "gnome" && has("eval")
  " Set useful keys that vim doesn't discover via termcap but are in the
  " builtin xterm termcap. See bug #122562. We use exec to avoid having to
  " include raw escapes in the file.
  exec "set <C-Left>=\eO5D"
  exec "set <C-Right>=\eO5C"
endif
" }}}
" {{{ Filetype plugin settings
" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
  " default.
  filetype indent on
endif
" }}}
