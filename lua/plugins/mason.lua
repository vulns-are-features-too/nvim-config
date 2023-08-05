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
    'bashls',
    'clangd',
    'csharp_ls',
    'gopls',
    'jsonls',
    'lua_ls',
    'marksman',
    php_lsp,
    'psalm',
    'pylsp',
    'rust_analyzer',
    'sqlls',
    'texlab',
    'tsserver',
    'vimls',
    'yamlls',
  },
})

require('mason-null-ls').setup({
  ensure_installed = {
    'black',
    'clang_format',
    'eslint',
    'jq',
    'phpstan',
    'prettier',
    'revive',
    'shellcheck',
    'shellharden',
    'shfmt',
    'staticcheck',
    'stylua',
  },
})

require('mason-nvim-dap').setup({
  ensure_installed = {
    'bash',
    'codelldb',
    'python',
  },
})
