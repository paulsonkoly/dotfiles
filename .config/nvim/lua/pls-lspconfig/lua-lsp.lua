local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

-- Check if it's already defined for when reloading this file.
if not lspconfig.lua_lsp then
  configs.lua_lsp = {
    default_config = {
      cmd = {'lua-lsp'};
      filetypes = {'lua'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
lspconfig.lua_lsp.setup{}
