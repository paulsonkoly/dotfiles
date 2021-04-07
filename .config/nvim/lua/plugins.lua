return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'cocopon/iceberg.vim'

  use "norcalli/nvim-colorizer.lua"
  use 'cossonleo/neo-smooth-scroll.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'onsails/lspkind-nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'windwp/nvim-autopairs'
  use 'kyazdani42/nvim-web-devicons'
  use { 'glepnir/galaxyline.nvim', branch = 'main' }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'TimUntersberger/neogit'
  use 'AndrewRadev/splitjoin.vim'
  use 'b3nj5m1n/kommentary'
end)
