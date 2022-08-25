" vim:fdm=marker
scriptencoding utf-8

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'azabiong/vim-highlighter'
Plug 'chrisbra/Colorizer'
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-dirvish'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gista'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neomake/neomake'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'rickhowe/diffchar.vim'
Plug 'slim-template/vim-slim'
Plug 't9md/vim-ruby-xmpfilter', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

call plug#end()
" }}} vim-plug

" generic global vim options {{{
set number
set relativenumber

set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
set colorcolumn=120
set nohlsearch

set hidden

let mapleader = '#'

" the default C-s freezes the terminal. C-z in insert is close enough.
imap <C-z> <Plug>Isurround
noremap ]g :cnext<CR>
noremap [g :cprevious<CR>
" }}} generic global vim options

" window movement / terminal mode maps {{{ "
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

tnoremap <C-\><C-\> <C-\><C-n>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" }}} window movement "

" Colorcheme overrides {{{
" only works before the colorscheme selection
augroup ColourScheme
    autocmd!
    autocmd ColorScheme * highlight NeomakeErrorSign ctermfg=203 ctermbg=235
                      \ | highlight NeomakeVirtualtextError ctermfg=203
                      \ | highlight link ExtraWhitespace ErrorMsg
    " Show leading white space that includes spaces, and trailing white space.
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
augroup END
highlight ExtraWhitespace ctermbg=red guibg=red
set background=dark
" }}} Colorscheme overrides

" visual appearance {{{
set listchars=trail:·
set list

" -- Insert -- on the command line
set noshowmode

set termguicolors
colorscheme iceberg
set cursorline

" }}} visual appearance

" lightline {{{
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ] },
  \ 'component_function': { 'gitbranch': 'gina#component#repo#branch' },
  \ 'colorscheme': 'iceberg'
  \ }
" }}} lightline

" Neomake {{{ "
call neomake#configure#automake('w')
let g:neomake_error_sign = {
      \ 'text': '●',
      \ 'texthl': 'NeomakeErrorSign',
      \ }
let g:neomake_warning_sign = {
      \   'text': '●',
      \   'texthl': 'NeomakeWarningSign',
      \ }
let g:neomake_message_sign = {
      \   'text': '●',
      \   'texthl': 'NeomakeMessageSign',
      \ }
let g:neomake_info_sign = {
      \ 'text': '●',
      \ 'texthl': 'NeomakeInfoSign'
      \ }
" }}} Neomake "

" easy align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}} easy align

" Git VCS {{{
map <leader>g :Gina status<CR>
map <leader>c :Gina commit<CR>
map <leader>l :Gina log --graph --all<CR>
map <leader>h :Gina branch<CR>
map <leader>s :Gina stash list<CR>

" allow gina to discard directories with == on Gina status. It asks for
" confirmation anyways
let g:gina#action#index#discard_directories=1

let g:gista#client#default_username='phaul'

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
augroup GinaStatus
  autocmd FileType gina-status setl number relativenumber
augroup end
" }}} Git VCS

" Ultisnips {{{
" directory must be in the runtime path!
let g:UltiSnipsSnippetsDir = '~/.local/share/nvim/site/UltiSnips'
augroup SnippetAuto
  autocmd FileType snippets setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2
augroup end
" }}} Ultisnips

" FZF {{{
map <leader>b :Buffers<CR>
map <leader>f :GFiles<CR>
map <leader><S-f> :GFiles?<CR>
map <leader>t :Filetypes<CR>
map <leader><leader> :BLines<CR>
map <leader>; :History:<CR>
" }}} FZF

" {{{ SplitJoin
let g:no_splitjoin_ruby_curly_braces=0
" }}} SplitJoin

" mark {{{ "
" this was mapping <Leader># which I use for :BLines
nmap <Plug>DisableMarkSearchCurrentPrev <Plug>MarkSearchCurrentPrev
" }}} mark "

" switch rb/rspec {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
" original stolen from https://raw.githubusercontent.com/garybernhardt/dotfiles/main/.vimrc
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1
        \ || match(current_file, '\<models\>') != -1
        \ || match(current_file, '\<workers\>') != -1
        \ || match(current_file, '\<views\>') != -1
        \ || match(current_file, '\<helpers\>') != -1
        \ || match(current_file, '\<services\>') != -1
        \ || match(current_file, '\<units\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
" }}} switch rb/rspec "
