let g:xmpfilter_cmd = 'seeing_is_believing'

nmap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)
xmap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)
imap <buffer> <Leader>m <Plug>(seeing_is_believing-mark)

nmap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)
xmap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)
imap <buffer> <Leader>r <Plug>(seeing_is_believing-run_-x)

" highlight operators in ruby
let ruby_operators=1
let ruby_spellcheck_strings=1
