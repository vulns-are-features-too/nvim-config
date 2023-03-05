require('mason').setup()

local php_lsp
local csharp_lsp

if vim.fn.has('linux') == 1 or vim.fn.has('unix') == 1 then
  -- Linux/Unix
  php_lsp = 'phpactor'
  csharp_lsp = 'omnisharp_mono'
else
  -- Windows
  php_lsp = 'intelephense'
  csharp_lsp = 'omnisharp'
end

require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    csharp_lsp,
    'diagnosticls',
    'efm',
    'eslint',
    'gopls',
    -- 'hls',
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
