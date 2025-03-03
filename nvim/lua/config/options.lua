-- Basic Neovim settings
local opt = vim.opt

-- UI
opt.relativenumber = true -- Relative line numbers
opt.number = true         -- Show line numbers

-- Indentation
opt.tabstop = 2           -- Number of spaces a tab counts for
opt.shiftwidth = 2        -- Number of spaces for autoindent
opt.expandtab = true      -- Use spaces instead of tabs

-- User experience
opt.mouse = 'a'           -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Use system clipboard
