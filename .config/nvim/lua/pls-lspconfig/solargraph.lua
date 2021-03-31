local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, result, { noremap = true, silent = true })
end

local custom_attach = function(client)
  mapper('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
end

lspconfig.solargraph.setup({
  filetypes = {'ruby'};
  root_dir = lspconfig.util.root_pattern('Gemfile', '.git'),
  settings = {
    solargraph = {
      transport = 'stdio'
    }
  },
  on_attach = custom_attach
})
