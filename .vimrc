""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'noprompt/vim-yardoc'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kana/vim-textobj-user'
Plugin 'junegunn/vim-easy-align'
Plugin 'fcpg/vim-farout'

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
