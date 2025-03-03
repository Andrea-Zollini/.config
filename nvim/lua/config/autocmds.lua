-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- LSP keybindings
autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = 'Go to definition' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = 'Hover documentation' })
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = true, desc = 'Rename symbol' })
      vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = 'Code actions' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true, desc = 'Find references' })
      vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = true, desc = 'Format document' })
    end
  end,
})
