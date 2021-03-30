local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

-- Check if it's already defined for when reloading this file.
if not lspconfig.solargraph then
  configs.solargraph = {
    default_config = {
      cmd = {'solargraph stdio'};
      filetypes = {'ruby'};
      root_dir = root_pattern('Gemfile', '.git');
      settings = {
        solargraph = {
          transport = 'stdio'
        };
      };
    }
  }
end
lspconfig.solargraph.setup{}
