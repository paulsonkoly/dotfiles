return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'cocopon/iceberg.vim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'windwp/nvim-autopairs'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    --config = function() require'my_statusline' end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'TimUntersberger/neogit'
  use 'AndrewRadev/splitjoin.vim'
  use 'b3nj5m1n/kommentary'
end)
