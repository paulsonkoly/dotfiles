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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ciaranm/inkpot'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'noprompt/vim-yardoc'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=DejaVu\ Sans\ Mono\ 10

" breaking bad habits
noremap <Up> <NOP>
inoremap <Up> <NOP>
noremap <Down> <NOP>
inoremap <Down> <NOP>
noremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Right> <NOP>

" inserting pair of parens etc
imap <Leader>" ""<Esc>i
imap <Leader>' ''<Esc>i
imap <Leader>( ()<Esc>i
imap <Leader>[ []<Esc>i
imap <Leader>{ {}<Esc>i

" insert a matching end
imap <S-CR> <CR><CR>end<Esc>-cc
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

colorscheme inkpot
let g:airline_theme = "bubblegum"

" u3301 doesn't appear correctly
let g:airline_symbols = {}
let g:airline_symbols.maxlinenr = 'Ln'

highlight Cursor guibg=#afd787

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ruby stuff
autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <Leader>m <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <Leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <Leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <Leader>r <Plug>(xmpfilter-run)
