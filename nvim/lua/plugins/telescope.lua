-- Telescope Configuration
local telescope = require('telescope')

-- Setup
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      },
    },
  },
})

-- Load extensions
telescope.load_extension('file_browser')

-- Keymaps
local keymap = vim.keymap.set
keymap('n', '<Leader>ff', require('telescope.builtin').find_files, { desc = 'Find files' })
keymap('n', '<Leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
keymap('n', '<Leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers' })
keymap('n', '<Leader>fh', require('telescope.builtin').help_tags, { desc = 'Find help tags' })
keymap('n', '<Leader>fe', telescope.extensions.file_browser.file_browser, { desc = 'File browser' })
