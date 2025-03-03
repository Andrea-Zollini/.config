-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before loading any plugins
vim.g.mapleader = ' '

-- Load core configuration
require('config')

-- Load plugins
require('plugins')

-- Force blade filetype
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.blade.php",
  callback = function()
    vim.bo.filetype = "blade"
    vim.cmd("TSBufEnable highlight")
  end
})
