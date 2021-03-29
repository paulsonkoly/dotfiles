local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

vim.g.mapleader = '#'
