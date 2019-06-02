" vim:fdm=marker
scriptencoding "utf-8"

" vim-plug {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bitc/vim-hdevtools'
Plug 'carmonw/elm-vim'
Plug 'cocopon/iceberg.vim'
Plug 'honza/vim-snippets'
"Plug 'https://manu@framagit.org/manu/coq-au-vim.git'
" coqprooject file support
Plug 'https://framagit.org/adamatousek/coq-au-vim.git'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jvoorhis/coq.vim'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gista'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'mcchrish/nnn.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'Pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rickhowe/diffchar.vim'
Plug 'simnalamburt/vim-mundo'
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

function! OpenTerminal() abort
  terminal
  exec "normal \<c-w>o"
endfunction

nnoremap <F6> :call OpenTerminal()<CR>
tnoremap <F6> <C-W>:call OpenTerminal()<CR>

function! OpenCmdTerm() abort
  terminal
  exec "normal \<c-w>L"
  exec 'file __cmd_window'
  exec "normal \<c-w>\<c-w>"
endfunction

function! SendCmdToTerm() abort
  if ! bufexists('__cmd_window')
    call OpenCmdTerm()
  endif

  if exists('b:cmd_command')
    let l:cmd = b:cmd_command
  else
    let l:cmd = g:cmd_command
  endif

  call term_sendkeys('__cmd_window', l:cmd)
endfunction

command! SendCmd call SendCmdToTerm()

let g:cmd_command = 'bundle exec rake spec'

nnoremap <F5> :w<CR>:SendCmd<CR>

" the default C-s freezes the terminal. C-z in insert is close enough.
imap <C-z> <Plug>Isurround

" gui {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=e  "no gui tab-bar
set guifont=Fantasque\ Sans\ Mono\ 12
" }}} gui "

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

" -- Insert -- on the command line
set noshowmode

colorscheme iceberg
set cursorline
" }}} visual appearance "

" airline {{{ "
let g:airline_powerline_fonts = 1
" disable orange - red syntastic bits when no warning/error
let w:airline_skip_empty_sections = 1
call airline#parts#define_function('gina', 'gina#component#repo#branch')
let g:airline_section_b = airline#section#create(['hunks', g:airline_symbols.branch,'gina'])
" }}} airline "

" JS/JSX {{{ "
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}
" JS/JSX }}} "

" Elm {{{ "
augroup ElmAuto
  autocmd FileType elm setlocal shiftwidth=4 softtabstop=4
augroup end
" }}} Elm "

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

" allow gina to discard directories with == on Gina status. It asks for
" confirmation anyways
let g:gina#action#index#discard_directories=1

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
augroup GinaStatus
  autocmd FileType gina-status setl number relativenumber
augroup end
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

" nnn {{{ "
let g:nnn#replace_netrw=1
" }}} nnn "
