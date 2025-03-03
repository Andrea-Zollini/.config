-- Treesitter Configuration
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "lua", "vim", "vimdoc", "query", -- Neovim relate1kd
    "javascript", "typescript", "tsx", "html", "css", -- Web development
    "php", "astro", "ruby", -- Other web languages
    "c", "cpp", -- C/C++
    "markdown", "json", -- Markup and data
    "git_rebase", "gitcommit", "gitignore", -- Git
    "blade",
    "vue", -- Vue support
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Indentation based on treesitter for the = operator
  indent = {
    enable = true,
  },

  -- Incremental selection based on the named nodes from the grammar
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", -- Start selection with Enter
      node_incremental = "<CR>", -- Increment selection to larger node with Enter
      scope_incremental = "<S-CR>", -- Increment to larger scope with Shift+Enter
      node_decremental = "<BS>", -- Decrement selection with Backspace
    },
  },
})


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade",
}

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
})

-- Enable folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Disable folding by default
