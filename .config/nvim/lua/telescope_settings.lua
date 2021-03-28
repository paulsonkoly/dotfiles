local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

map('n', '<leader>b', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>f', '<cmd>Telescope git_files<cr>', opts)
map('n', '<leader>t', '<cmd>Telescope filetypes<cr>', opts)
map('n', '<leader><leader>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
map('n', '<leader>;', '<cmd>Telescope command_history<cr>', opts)
