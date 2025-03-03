-- LSP Configuration
local lspconfig = require('lspconfig')

-- Setup Mason and Mason-lspconfig
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'intelephense',
    'clangd',
    'ruby_lsp',
    'astro',
    'tailwindcss',
    'emmet_ls',
  },
})

-- Helper function to setup LSP servers with blink.cmp capabilities
local function setup_server(server, config)
  config = config or {}
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  lspconfig[server].setup(config)
end

-- Configure servers
setup_server('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

setup_server('intelephense', {
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
      },
      diagnostics = {
        enable = true,
      },
    },
  },
})

setup_server('clangd', {
  cmd = { 'clangd', '--background-index' },
})

setup_server('ruby_lsp', {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  init_options = {
    formatter = 'auto',
  },
  single_file_support = true,
})

setup_server('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  init_options = {
    typescript = {},
  },
})

setup_server('emmet_ls', {
  cmd = { 'emmet-ls', '--stdio' },
  filetypes = {
    'astro', 'css', 'eruby', 'html', 'htmldjango', 'javascriptreact', 
    'less', 'pug', 'sass', 'scss', 'svelte', 'typescriptreact', 'vue', 'htmlangular'
  },
  single_file_support = true,
})

setup_server('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 
    'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 
    'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 
    'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 
    'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 
    'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 
    'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ'
  },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        htmlangular = 'html',
        templ = 'html',
      },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning',
      },
      validate = true,
    },
  },
})
