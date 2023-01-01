local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local vtypes = require('virtualtypes').on_attach

capabilities.offsetEncoding = { 'utf-16' }

-- General
lsp.diagnosticls.setup({
  capabilities = capabilities,
  -- on_attach = function() end,
})

lsp.efm.setup({
  capabilities = capabilities,
  -- on_attach = function() end,
})

-- Bash
lsp.bashls.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
})

-- C/C++
lsp.clangd.setup({
  capabilities = capabilities,
  on_attach = vtypes,
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    require('lang.go')
    vtypes()
  end,
})

-- Haskell
require('lspconfig').hls.setup({
  capabilities = capabilities,
})

-- Java
-- TODO

-- Javascript/Typescript
lsp.eslint.setup({})
lsp.tsserver.setup({})

-- JSON
lsp.jsonls.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
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
  -- on_attach = function(client, bufnr) end,
})

-- Markdown
lsp.marksman.setup({
  capabilities = capabilities,
  on_attach = function(_, _) require('lang.markdown') end,
})

-- PHP
lsp.phpactor.setup({})

-- Python
lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    vtypes()
  end,
})

-- Rust
lsp.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = vtypes,
})

-- SQL
lsp.sqlls.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
})

-- LaTeX
lsp.texlab.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
})

-- Vim
lsp.vimls.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
})

-- YAML
lsp.yamlls.setup({
  capabilities = capabilities,
  -- on_attach = function(client, bufnr) end,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

-- keymaps
local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false, silent = true }) end
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
