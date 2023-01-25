local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local vtypes = require('virtualtypes').on_attach
local is_linux = vim.fn.has('linux') or vim.fn.has('unix')
local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end

local function map_keys()
  nmap('K', vim.lsp.buf.hover)
  nmap('<C-k>', vim.lsp.buf.signature_help)
  nmap('gd', vim.lsp.buf.definition)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gt', vim.lsp.buf.type_definition)
  nmap('gi', vim.lsp.buf.implementation)
  nmap('<space>r', vim.lsp.buf.rename)
  nmap('<space>a', vim.lsp.buf.code_action)
  nmap(']e', vim.diagnostic.goto_next)
  nmap('[e', vim.diagnostic.goto_prev)
  nmap('<leader>f', vim.lsp.buf.format)
end

capabilities.offsetEncoding = { 'utf-16' }

-- General
lsp.diagnosticls.setup({
  capabilities = capabilities,
})

lsp.efm.setup({
  capabilities = capabilities,
})

-- Bash
lsp.bashls.setup({
  capabilities = capabilities,
  on_attach = map_keys,
})

-- C/C++
lsp.clangd.setup({
  capabilities = capabilities,
  on_attach = function()
    vtypes()
    map_keys()
  end,
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    require('lang.go')
    vtypes()
    map_keys()
  end,
})

-- Haskell
lsp.hls.setup({
  capabilities = capabilities,
  on_attach = map_keys,
})

-- Java
-- TODO

-- Javascript/Typescript
lsp.eslint.setup({
  capabilities = capabilities,
})
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = map_keys,
})

-- JSON
lsp.jsonls.setup({
  capabilities = capabilities,
})

-- Lua
lsp.sumneko_lua.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'packer_plugins' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
    },
  },
  on_attach = map_keys,
})

-- Markdown
lsp.marksman.setup({
  capabilities = capabilities,
  on_attach = function()
    require('lang.markdown')
    map_keys()
  end,
})

-- PHP
lsp.psalm.setup({})
if is_linux then
  lsp.phpactor.setup({
    init_options = {
      ['language_server_phpstan.enabled'] = true,
      ['language_server_psalm.enabled'] = true,
    },
    on_attach = function()
      vtypes()
      map_keys()
    end,
  })
else
  -- phpactor isn't available on Windows so I'm stuck with this proprietary thing for now
  lsp.intelephense.setup({
    on_attach = function()
      vtypes()
      map_keys()
    end,
  })
end

-- Python
lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = function()
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    vtypes()
    map_keys()
  end,
})

-- Rust
lsp.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = function()
    vtypes()
    map_keys()
  end,
})

-- SQL
lsp.sqlls.setup({
  capabilities = capabilities,
  on_attach = map_keys,
})

-- LaTeX
lsp.texlab.setup({
  capabilities = capabilities,
})

-- Vim
lsp.vimls.setup({
  capabilities = capabilities,
  on_attach = map_keys,
})

-- YAML
lsp.yamlls.setup({
  capabilities = capabilities,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

nmap('<leader>ll', '<Cmd>LspInfo<CR>')
nmap('<leader>lm', '<Cmd>Mason<CR>')
