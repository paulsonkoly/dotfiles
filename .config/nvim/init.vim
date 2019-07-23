" vim-plug {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'cocopon/iceberg.vim'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gista'
Plug 'machakann/vim-highlightedyank'
Plug 'mcchrish/nnn.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'rickhowe/diffchar.vim'
Plug 'SirVer/ultisnips'
Plug 't9md/vim-ruby-xmpfilter', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Twinside/vim-hoogle'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'wellle/targets.vim'

call plug#end()
" }}} vim-plug "


" visual appearance {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" this needs to be *before* the first colour scheme command, otherwise it
" might be overridden
highlight ExtraWhitespace ctermbg=red guibg=red
augroup ColorAuto
  autocmd ColorScheme * highlight link ExtraWhitespace ErrorMsg
  " Show leading white space that includes spaces, and trailing white space.
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
augroup end
set listchars=trail:·
set list

" -- Insert -- on the command line
set noshowmode

colorscheme iceberg
set cursorline

" }}} visual appearance "

" Git VCS {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>g :Gina status<CR>
map <leader>c :Gina commit<CR>
map <leader>l :Gina log --graph --all<CR>

" allow gina to discard directories with == on Gina status. It asks for
" confirmation anyways
let g:gina#action#index#discard_directories=1

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
augroup GinaStatus
  autocmd FileType gina-status setl number relativenumber
augroup end
" }}} Git VCS "

