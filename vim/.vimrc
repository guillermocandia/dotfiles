" Configuration file for vim
set runtimepath=~/.vim,~/.vimfiles,/etc/local/vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/addons,/usr/local/share/vim/vim71,/usr/local/share/vim/vimfiles,/usr/local/share/vim/addons/after,/usr/local/bin


" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

" Now we set some defaults for the editor 
set autoindent		" always set autoindenting on
" set linebreak		" Don't wrap words by default
set textwidth=0		" Don't wrap lines by default 
set backupcopy=yes	" Keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

if has("autocmd")
 " Enabled file type detection
 " Use the default filetype settings. If you also want to load indent files
 " to automatically do language-dependent indenting add 'indent' as well.
 filetype plugin on

endif " has ("autocmd")

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*		set ft=mail
  au BufRead reportbug-*		set ft=mail
augroup END

" Set paper size from /etc/papersize if available (Debian-specific)
try
  if filereadable('/etc/papersize')
    let s:papersize = matchstr(system('/bin/cat /etc/papersize'), '\p*')
    if strlen(s:papersize)
      let &printoptions = "paper:" . s:papersize
    endif
    unlet! s:papersize
  endif
catch /E145/
endtry

" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
""set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

"nnoremap <leader>f :call CHeaderFinder_HeadersFromFuncUnderCursor()<CR>
"nnoremap <leader>a :call CHeaderFinder_GotoHeaderFromFuncUnderCursor()<CR>

" cambios a mi pinta 
set number
set backup
set backupext=.bak
"set patchmode=.orig
set foldmethod=marker
set foldmarker={{{,}}}
set nowrap
set list
set tabstop=4
set expandtab
set listchars=trail:-,tab:\|\ ,eol:.,extends:»,precedes:«
""inoremap { {<CR>}<ESC>O<TAB>
""inoremap ( ()<ESC>ha
""inoremap " ""<ESC>ha
""inoremap < <><ESC>ha
set showmode
colorscheme darkblue
