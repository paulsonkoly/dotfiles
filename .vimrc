""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'fcpg/vim-farout'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'noprompt/vim-yardoc'
Plugin 'SirVer/ultisnips'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'VundleVim/Vundle.vim'

call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=DejaVu\ Sans\ Mono\ 10

" breaking bad habits
noremap  <Up>    <NOP>
inoremap <Up>    <NOP>
noremap  <Down>  <NOP>
inoremap <Down>  <NOP>
noremap  <Left>  <NOP>
inoremap <Left>  <NOP>
noremap  <Right> <NOP>
inoremap <Right> <NOP>

"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" visual appearance
" this needs to be *before* the first colour scheme command, otherwise it
" might be overridden
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=LightCoral
" Show leading white space that includes spaces, and trailing white space.
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
set listchars=trail:·
set list

syntax on

colorscheme farout

" this setup matches the fzf logo on a statusbar background
hi fzf1 guifg=#f80069 guibg=#291916
hi fzf2 guifg=#b0e1bd guibg=#291916
hi fzf3 guifg=#e9e9e9 guibg=#291916

let g:gitgutter_sign_added = '⬤'
let g:gitgutter_sign_modified = '⬤'
let g:gitgutter_sign_removed = '⬤'
let g:gitgutter_sign_modified_removed = '⬤'

hi GitGutterAdd guifg=#0f2108
hi GitGutterChange guifg=#272406
hi GitGutterDelete guifg=#2f0908

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" statusline
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%y\ %-14.(%l,%c%V%)\ %P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                     " show line numbers
set relativenumber             " relative numbers to current line

set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
set colorcolumn=80

set spelllang=en_gb

" this setting makes file related commands to look in sub folders recursively
set path+=**

" this is the tab menu for different options on finding files
set wildmenu

" insert a matching end
autocmd FileType ruby map <buffer> <S-CR> <Esc>A<CR><CR>end<Esc>-cc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ruby stuff
autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <Leader>m <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <Leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <Leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <Leader>r <Plug>(xmpfilter-run)

" highlight operators in ruby
let ruby_operators=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchit for ruby do-end if-end etc
" This is also required for ruby text objects to work, as the plugin uses % to
" get the ends of the block.
runtime macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grepping
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
