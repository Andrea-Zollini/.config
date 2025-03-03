-- Colorscheme Configuration
require('catppuccin').setup({
  flavour = 'mocha', -- Set the flavor to Mocha
  transparent_background = false, -- Set to true if you want a transparent background
  integrations = {
    telescope = true, -- Enable Telescope integration
    mason = true, -- Enable Mason integration
    native_lsp = { -- Use 'native_lsp' instead of 'lspconfig'
      enabled = true,
    },
  },
})

-- Set colorscheme
vim.cmd.colorscheme('catppuccin')
