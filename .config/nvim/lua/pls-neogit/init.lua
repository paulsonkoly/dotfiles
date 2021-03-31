require('neogit').setup {}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

map('n', '<Leader>g', '<cmd>Neogit<CR>', opts)
