" vim:fdm=marker
scriptencoding "utf-8"

" vim-plug {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/gina.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-markdown-folding'
Plug 'noprompt/vim-yardoc'
Plug 'SirVer/ultisnips'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'wellle/targets.vim'

call plug#end()
" }}} vim-plug "

" gui {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=e  "no gui tab-bar
set guifont=Fantasque\ Sans\ Mono\ 11
" }}} gui "

" breaking bad habits {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap  <Up>    <NOP>
inoremap <Up>    <NOP>
noremap  <Down>  <NOP>
inoremap <Down>  <NOP>
noremap  <Left>  <NOP>
inoremap <Left>  <NOP>
noremap  <Right> <NOP>
inoremap <Right> <NOP>
" breaking bad habits }}} "

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

syntax on

colorscheme onedark
" }}} visual appearance "

" statusline {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi StatusLineFileType guifg=#98c379 guibg=#2c323c
hi link StatusLineGit WildMenu
set laststatus=2
" left hand side
set statusline=%<%f\ %h%m%r
set statusline+=%#StatusLineGit#%{gina#component#repo#branch()}
set statusline+=%{gina#component#status#preset('fancy')}%*
" left-right separator
set statusline+=%=
" right hand side
"syntastic
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%#StatusLineFileType#%y%*\ %-14.(%l,%c%V%)\ %P
" }}} statusline "

" generic global vim options {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                     " show line numbers
set relativenumber             " relative numbers to current line

set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
set colorcolumn=80

set spelllang=en_gb

" remove the comment mark when J concatenating two comment lines
set formatoptions+=j

" this setting makes file related commands to look in sub folders recursively
set path+=**

" this is the tab menu for different options on finding files
set wildmenu

" allow to navigate away from unsaved buffers
set hidden

" highlight partial hits during a search
set incsearch
" }}} generic global vim options "

" ruby stuff {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add the tags file from the root of each gem referenced from the current bundle
" the current bundle is set by cwd
function! SetBundlerTags()
  let &l:tags .= ',' . system('bundled.rb')
endfunction

augroup RubyAuto
  autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
  autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(xmpfilter-mark)
  autocmd FileType ruby imap <buffer> <Leader>m <Plug>(xmpfilter-mark)

  autocmd FileType ruby nmap <buffer> <Leader>r <Plug>(xmpfilter-run)
  autocmd FileType ruby xmap <buffer> <Leader>r <Plug>(xmpfilter-run)
  autocmd FileType ruby imap <buffer> <Leader>r <Plug>(xmpfilter-run)

  " insert a matching end
  autocmd FileType ruby nnoremap <buffer> <S-CR> <Esc>A<CR><CR>end<Esc>-cc
  autocmd FileType ruby inoremap <buffer> <S-CR> <Esc>A<CR><CR>end<Esc>-cc

  autocmd FileType ruby call SetBundlerTags()
augroup end

" highlight operators in ruby
let ruby_operators=1
let ruby_spellcheck_strings=1
" }}} ruby stuff "

" matchit {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchit for ruby do-end if-end etc
" This is also required for ruby text objects to work, as the plugin uses % to
" get the ends of the block.
runtime macros/matchit.vim
" }}} matchit "

" grepping {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  set grepprg=ag\ --vimgrep\ --ignore-case
endif
" }}} grepping "

" easy align {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}} easy align "

" gitgutter {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
" }}} gitgutter "

" Ultisnips {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" directory must be in the runtime path!
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
augroup SnippetAuto
  autocmd FileType snippets set noexpandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup end
" }}} Ultisnips "

" Syntastic {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
nnoremap ]s :lnext<CR>
nnoremap [s :lprevious<CR>

let g:syntastic_vim_checkers = ['vint']
" }}} Syntastic "

" FZF {{{ "
map <leader>f :Buffers<CR>
" }}} FZF"

" {{{ SplitJoin "
let g:no_splitjoin_ruby_curly_braces=0
" }}} SplitJoin "
