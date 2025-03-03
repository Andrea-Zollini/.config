-- Plugin setup with lazy.nvim
return require('lazy').setup({
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('plugins.lsp')
    end,
  },
  
  -- Telescope (Fuzzy Finder)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      require('plugins.telescope')
    end,
  },
  
  -- Catppuccin Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('plugins.colorscheme')
    end,
  },
  
  -- Completion
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    config = function()
      require('plugins.completion')
    end,
  },

  -- Auto-pairs for bracket completion
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('plugins.autopairs')
    end,
  },
})
