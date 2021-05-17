set nocompatible

syntax on
filetype plugin indent on

set ruler
set encoding=utf-8
set autoindent
set rnu
set nu
set smartindent
set textwidth=80
set colorcolumn=+1

highlight ColorColumn ctermbg=0 guibg=lightgrey

:imap jk <Esc>
function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
    set nu
  else
    set rnu
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

