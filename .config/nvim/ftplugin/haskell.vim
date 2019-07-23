augroup interoMaps
  au!
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
augroup END


setlocal formatprg=brittany
nmap <F2> :HoogleInfo<CR>
nnoremap <silent> <F3> :InteroOpen<CR>

" Load individual modules
nnoremap <silent> <F4> :InteroLoadCurrentModule<CR>
nnoremap <silent> <F5> :InteroLoadCurrentFile<CR>

" Type-related information
" Heads up! These next two differ from the rest.
map <silent> <F6> <Plug>InteroGenericType
map <silent> <F7> <Plug>InteroType
nnoremap <silent> <F8> :InteroTypeInsert<CR>

" Navigation
nnoremap <silent> <F9> :InteroGoToDef<CR>

" Managing targets
" Prompts you to enter targets (no silent):
nnoremap <F10> :InteroSetTargets<SPACE>

nnoremap <F11> :Neomake hlint<CR>
