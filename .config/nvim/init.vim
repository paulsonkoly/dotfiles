" vim:fdm=marker
scriptencoding utf-8

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'ElmCast/elm-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'airblade/vim-gitgutter'
Plug 'cocopon/iceberg.vim'
Plug 'diepm/vim-rest-console'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kkoomen/vim-doge'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gista'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'mcchrish/nnn.vim'
Plug 'neomake/neomake'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell'}
Plug 'rickhowe/diffchar.vim'
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

set hidden

" the default C-s freezes the terminal. C-z in insert is close enough.
imap <C-z> <Plug>Isurround
noremap ]g :cnext<CR>
noremap [g :cprevious<CR>
" }}} generic global vim options

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
" }}} Colorscheme overrides

" visual appearance {{{
set listchars=trail:·
set list

" -- Insert -- on the command line
set noshowmode

colorscheme iceberg
set cursorline

" }}} visual appearance

" lightline {{{
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'platform', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ] },
  \ 'component_function': { 'gitbranch': 'gina#component#repo#branch' },
  \ 'component': { 'platform': $CURRENT_PLATFORM },
  \ 'colorscheme': 'wombat'
  \ }
" }}} lightline

" Neomake {{{ "
call neomake#configure#automake('w')
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

" nnn {{{
let g:nnn#replace_netrw=1
" }}} nnn

" VRC {{{ "
let g:vrc_set_default_mapping = 0
map <Leader>r :call VrcQuery()<CR>
" }}} VRC "
