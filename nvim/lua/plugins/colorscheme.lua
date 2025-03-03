-- Colorscheme Configuration
local catppuccin = require('catppuccin')

local current_flavour = 'macchiato' -- Start with Macchiato

local function setup_catppuccin(flavour)
  catppuccin.setup({
    flavour = flavour,
    transparent_background = false,
    integrations = {
      telescope = true,
      mason = true,
      native_lsp = {
        enabled = true,
      },
    },
  })
  vim.cmd.colorscheme('catppuccin')
end

-- Initial setup
setup_catppuccin(current_flavour)

local function toggle_theme()
  if current_flavour == 'latte' then
    current_flavour = 'macchiato'
  else
    current_flavour = 'latte'
  end
  setup_catppuccin(current_flavour)
end

-- Keymap to toggle theme
vim.api.nvim_set_keymap('n', '<leader>ct', ':lua require("plugins.colorscheme").toggle_theme()<CR>', { noremap = true, silent = true, desc = 'Toggle Catppuccin Theme' })

return {
  toggle_theme = toggle_theme,
}

