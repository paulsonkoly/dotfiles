return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'cocopon/iceberg.vim'

  use 'AndrewRadev/splitjoin.vim'
  use "b3nj5m1n/kommentary"
  use 'cossonleo/neo-smooth-scroll.nvim'
  use { 'glepnir/galaxyline.nvim', branch = 'main' }
  use 'hrsh7th/nvim-compe'
  use 'kyazdani42/nvim-web-devicons'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { '/lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use 'neovim/nvim-lspconfig'
  use "norcalli/nvim-colorizer.lua"
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'nvim-treesitter/nvim-treesitter'
  use 'onsails/lspkind-nvim'
  use { 'SirVer/ultisnips', requires = { 'honza/vim-snippets' } }
  use 'TimUntersberger/neogit'
  use "tversteeg/registers.nvim"
  use "tweekmonster/startuptime.vim"
  use 'windwp/nvim-autopairs'
end)
