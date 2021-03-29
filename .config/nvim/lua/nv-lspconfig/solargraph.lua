local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

-- Check if it's already defined for when reloading this file.
if not lspconfig.solargraph then
  configs.solargraph = {
    default_config = {
      cmd = {'solargraph stdio'};
      filetypes = {'ruby'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
lspconfig.solargraph.setup{}
