vim.o.termguicolors = true

-- this has to be before the colorscheme is chosen
vim.api.nvim_exec([[
augroup ColourScheme
  autocmd!
  autocmd ColorScheme * highlight link ExtraWhitespace ErrorMsg
  autocmd ColorScheme * highlight link GitSignsAdd GitGutterAdd
  autocmd ColorScheme * highlight link GitSignsChange GitGutterChange
  autocmd ColorScheme * highlight link GitSignsDelete GitGutterDelete
  autocmd ColorScheme * highlight! LspDiagnosticsSignError guifg=#f44747 guibg=#1e2132
  autocmd ColorScheme * highlight! LspDiagnosticsSignWarning guifg=#ff8800 guibg=#1e2132
  autocmd ColorScheme * highlight! LspDiagnosticsSignHint guifg=#4fc1ff guibg=#1e2132
  autocmd ColorScheme * highlight! LspDiagnosticsSignInformation guifg=#ffcc66 guibg=#1e2132
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
augroup END
]], false)

vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')

vim.cmd('colorscheme iceberg')

vim.api.nvim_exec([[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
]], false)

