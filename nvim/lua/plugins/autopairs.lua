-- Auto-pairs configuration
local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,  -- Use treesitter if available
  ts_config = {
    lua = {'string'},  -- Don't add pairs in lua string treesitter nodes
    javascript = {'template_string'},  -- Don't add pairs in javascript template_string
  },
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = '<M-e>',  -- Alt+e to wrap with brackets
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
})

-- Skip the CMP integration since you're using blink.cmp
-- If blink.cmp supports an event system in the future, you can add it back
