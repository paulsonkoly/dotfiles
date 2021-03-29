vim.o.termguicolors = true

-- this has to be before the colorscheme is chosen
vim.api.nvim_exec([[
augroup ColourScheme
  autocmd!
  autocmd ColorScheme * highlight link ExtraWhitespace ErrorMsg
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

