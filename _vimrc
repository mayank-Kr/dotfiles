" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

"---------------------
" Basic editing config
"---------------------
set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set backup
set backupdir=C:\WINDOWS\Temp
set backupskip=C:\WINDOWS\Temp\*
set directory=C:\WINDOWS\Temp
set writebackup

"The line below uses a file namef skeleton.cpp as template for new cpp files
"the HOME variable expands to C:\users\<username>\
autocmd BufNewFile *.cpp 0r $HOME\vimfiles\skeleton.cpp
"the below line compiles and runs cpp files in windows
"autocmd vimEnter *.cpp map <F8> :w <CR> :!g++ --std=c++17 % -o %:r <CR> :!%:r.exe <CR>
autocmd vimEnter *.cpp map <F8> :w <CR> :!g++ --std=c++17 % -o %:r <CR> :!%:r.exe <CR>
autocmd vimEnter *.cpp map <F5> :w <CR> :!g++ --std=c++17 % -o %:r <CR>
autocmd vimEnter *.cpp map <F6> :w <CR> :!%:r.exe <CR>
"the below line will work for linux
"autocmd vimEnter *.cpp map <F8> :w <CR> :!g++ --std=c++17 % -o %:r <CR> :!%:r <CR>

map <F2> :w <CR>
map <S-c> :%y+ <CR>
map <S-l> "+dd
map <C-x> "+x
map <C-C> "+y
map <S-v> "+p

" Use the internal diff if available.
filetype plugin indent on
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
