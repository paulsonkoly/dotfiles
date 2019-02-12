" vim:fdm=marker
scriptencoding "utf-8"

" vim-plug {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'cocopon/iceberg.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gista'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim', { 'for': ['eruby', 'html'] }
Plug 'mcchrish/nnn.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'simnalamburt/vim-mundo'
Plug 'SirVer/ultisnips'
Plug 't9md/vim-ruby-xmpfilter', { 'for': 'ruby' }
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
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

" ruby stuff {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add the tags file from the root of each gem referenced from the current bundle
" the current bundle is set by cwd
function! SetBundlerTags()
  let &l:tags .= ',' . system('bundled.rb')
endfunction

function! OpenRspecTerm() abort
  terminal
  exec "normal \<c-w>L"
  exec 'file __rspec'
  exec "normal \<c-w>\<c-w>"
endfunction

function! SendRspecToTerm() abort
  if ! bufexists('__rspec')
    call OpenRspecTerm()
  endif

  call term_sendkeys('__rspec', g:ruby_rspec_command)
endfunction

command! SendRSpec call SendRspecToTerm()

let g:ruby_rspec_command = 'bundle exec rake spec'
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

  autocmd FileType ruby nnoremap <buffer> <F5> :SendRSpec<CR>

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

" Git VCS {{{ "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>g :Gina status<CR>
map <leader>c :Gina commit<CR>
map <leader>l :Gina log --graph --all<CR>

" allow gina to discard directories with == oon Gina status. It asks for
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
