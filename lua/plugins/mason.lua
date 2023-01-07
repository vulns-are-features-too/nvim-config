require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'diagnosticls',
    'efm',
    'eslint',
    'gopls',
    -- 'hls',
    'jsonls',
    'marksman',
    'phpactor',
    'pylsp',
    'rust_analyzer',
    'sqlls',
    'sumneko_lua',
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
    'eslint_d',
    'goimports',
    'jq',
    'mypy',
    'prettier',
    'pylint',
    'revive',
    'rustfmt',
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
