require('mason').setup()

local php_lsp

if vim.fn.has('linux') == 1 or vim.fn.has('unix') == 1 then
  -- Linux/Unix
  php_lsp = 'phpactor'
else
  -- Windows
  php_lsp = 'intelephense'
end

require('mason-lspconfig').setup({
  ensure_installed = {
    -- 'bashls',
    -- 'clangd',
    -- 'csharp_ls',
    -- 'gopls',
    -- 'jsonls',
    -- 'lua_ls',
    -- 'marksman',
    -- php_lsp,
    -- 'psalm',
    -- 'sqlls',
    -- 'texlab',
    -- 'tsserver',
    -- 'vimls',
    -- 'yamlls',
  },
})

require('mason-null-ls').setup({
  ensure_installed = {
    -- 'clang_format',
    -- 'eslint',
    -- 'phpstan',
    -- 'prettier',
    -- 'revive',
    -- 'shellcheck',
    -- 'shellharden',
    -- 'shfmt',
    -- 'staticcheck',
    -- 'stylua',
  },
})

require('mason-nvim-dap').setup({
  ensure_installed = {
    -- 'bash',
    -- 'codelldb',
    -- 'python',
  },
})
