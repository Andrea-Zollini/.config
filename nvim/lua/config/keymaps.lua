-- General keymaps (non-plugin related)
local keymap = vim.keymap.set

-- Clipboard operations
keymap('n', '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })
keymap('v', '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })
keymap('n', '<Leader>p', '"+p', { desc = 'Paste from system clipboard' })
keymap('v', '<Leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- Reload config
keymap('n', '<Leader>r', function()
  vim.cmd('source $MYVIMRC')
  print('Neovim config reloaded!')
end, { desc = 'Reload config' })
