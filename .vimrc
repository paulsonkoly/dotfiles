" vim:fdm=marker
scriptencoding "utf-8"

" vim-plug {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'cocopon/iceberg.vim'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/gina.vim'
Plug 'mattn/emmet-vim', { 'for': ['eruby', 'html'] }
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'Pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'SirVer/ultisnips'
Plug 't9md/vim-ruby-xmpfilter', { 'for': 'ruby' }
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
Plug 'wellle/targets.vim'

call plug#end()
" }}} vim-plug "

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
let g:hardtime_default_on = 1
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

colorscheme iceberg
set cursorline
" }}} visual appearance "

" statusline {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
" left hand side
set statusline=%<%f\ %h%m%r
set statusline+=%{gina#component#repo#branch()}
set statusline+=%{gina#component#status#preset('fancy')}%*
" left-right separator
set statusline+=%=
" right hand side
"syntastic
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%y%*\ %-14.(%l,%c%V%)\ %P
" }}} statusline "

" ruby stuff {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add the tags file from the root of each gem referenced from the current bundle
" the current bundle is set by cwd
function! SetBundlerTags()
  let &l:tags .= ',' . system('bundled.rb')
endfunction

let g:xmpfilter_cmd = 'seeing_is_believing'

augroup RubyAuto
  autocmd FileType ruby nmap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)
  autocmd FileType ruby xmap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)
  autocmd FileType ruby imap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)

  autocmd FileType ruby nmap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)
  autocmd FileType ruby xmap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)
  autocmd FileType ruby imap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)

  " insert a matching end
  autocmd FileType ruby nnoremap <buffer> <S-CR> <Esc>A<CR><CR>end<Esc>-cc
  autocmd FileType ruby inoremap <buffer> <S-CR> <Esc>A<CR><CR>end<Esc>-cc

  autocmd FileType ruby call SetBundlerTags()
augroup end

" highlight operators in ruby
let ruby_operators=1
let ruby_spellcheck_strings=1
" }}} ruby stuff "

" JS/JSX {{{ "
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}
" JS/JSX }}} "

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

" Git VCS {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>g :Gina status<CR>
map <leader>c :Gina commit<CR>
map <leader>l :Gina log --graph --all<CR>
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
" }}} Git VCS "

" Ultisnips {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" directory must be in the runtime path!
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
augroup SnippetAuto
  autocmd FileType snippets setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup end
" }}} Ultisnips "

" Syntastic {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

let g:syntastic_vim_checkers = ['vint']
" }}} Syntastic "

" FZF {{{ "
map <leader>f :Buffers<CR>
" }}} FZF"

" {{{ SplitJoin "
let g:no_splitjoin_ruby_curly_braces=0
" }}} SplitJoin "
