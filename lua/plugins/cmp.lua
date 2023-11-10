local cmp = require('cmp')
local format = require('lspkind').cmp_format
local map = cmp.mapping

cmp.setup({
  mapping = map.preset.insert({
    ['<C-p>'] = map.complete(),
    ['<TAB>'] = map.select_next_item(),
    ['<S-TAB>'] = map.select_prev_item(),
    ['<C-j>'] = map.select_next_item(),
    ['<C-k>'] = map.select_prev_item(),
    ['<C-S-b>'] = map(map.scroll_docs(-4), { 'i', 'c' }),
    ['<C-S-n>'] = map(map.scroll_docs(4), { 'i', 'c' }),
    ['<C-q>'] = map({
      i = map.abort(),
      c = map.close(),
    }),
    ['<C-space>'] = map.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<CR>'] = map.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
  }),

  sources = {
    { name = 'luasnip' },
    -- source from all buffers
    { name = 'buffer', option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } },
    { name = 'bufname' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'cmdline' },
  },

  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = format({
      mode = 'text',
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lsp_signature_help = '[sig]',
        nvim_lua = '[NvimLua]',
        buffer = '[Buffer]',
        bufname = '[Buffer]',
        luasnip = '[Snip]',
        path = '[Path]',
        cmdline = '[CMD]',
      },
    }),
    expandable_indicator = true,
  },

  experimental = {
    ghost_text = true,
  },

  -- cmp-dap
  enabled = function()
    return vim.api.nvim_get_option_value('buftype', {}) ~= 'prompt' or require('cmp_dap').is_dap_buffer()
  end,
})

cmp.setup.cmdline(':!', {
  sources = {
    { name = 'cmdline' },
  },
})

-- SQL
cmp.setup.filetype({ 'sql', 'mysql', 'psql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer', option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
})

-- cmp-dap
cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, {
  sources = {
    { name = 'dap' },
  },
})

-- git commit
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'buffer' },
  }),
})

-- justfile
cmp.setup.filetype('just', {
  sources = cmp.config.sources({
    { name = 'buffer' },
    { name = 'path' },
  }),
})
