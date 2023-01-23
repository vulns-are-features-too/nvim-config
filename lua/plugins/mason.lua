require('mason').setup()

local is_linux = vim.fn.has('linux') or vim.fn.has('unix')
local php_lsp = is_linux and 'phpactor' or 'intelephense'

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
    php_lsp,
    'psalm',
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
    'phpstan',
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
