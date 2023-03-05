local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local is_linux = vim.fn.has('linux') == 1 or vim.fn.has('unix') == 1

local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, silent = true, desc = desc }) end

local function nvmap(key, target, desc)
  vim.keymap.set({ 'n', 'v' }, key, target, { remap = false, silent = true, desc = desc })
end

-- keymap targets
local k_actions = vim.lsp.buf.code_action
local k_rename = vim.lsp.buf.rename
local k_diagnostics = vim.diagnostic.open_float
local k_diag_next = vim.diagnostic.goto_next
local k_diag_prev = vim.diagnostic.goto_prev
local k_hover = vim.lsp.buf.hover

local function setup_keymaps()
  nmap('K', k_hover, 'Signature hover')
  nmap('H', vim.lsp.buf.signature_help, 'Signature help')
  nmap('<leader>f', vim.lsp.buf.format, 'Format')
  nmap('<space><space>f', vim.lsp.buf.format, 'Format')
  nmap('<space>dd', k_diagnostics, 'Line diagnostics')
  nmap('[e', k_diag_prev, 'Go to previous diagnostics')
  nmap(']e', k_diag_next, 'Go to next diagnostics')
  nmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
  nmap('gt', vim.lsp.buf.type_definition, 'Go to type definition')
  nmap('<space>lr', k_rename, 'Rename')
  nvmap('<space>a', k_actions, 'Code action')
end

local function setup_saga()
  local ok, saga = pcall(require, 'lspsaga')
  if ok then
    saga.setup({
      finder = {
        edit = '<CR>',
        vsplit = '<C-k>',
        split = '<C-j>',
        tabe = '<C-t>',
        quit = { 'q', '<ESC>' },
      },
      definition = {
        edit = '<C-c>o',
        vsplit = '<C-c>k',
        split = '<C-c>j',
        tabe = '<C-c>t',
        quit = 'q',
        close = '<Esc>',
      },
      rename = {
        quit = '<C-c>',
        exec = '<CR>',
        mark = 'x',
        confirm = '<CR>',
        in_select = false,
      },
      code_action = {
        num_shortcut = true,
        keys = {
          quit = { 'q', '<ESC>' },
          exec = '<CR>',
        },
      },
      lightbulb = { enable = false },
      beacon = { enable = false },
    })

    k_actions = '<Cmd>Lspsaga code_action<CR>'
    k_diag_prev = '<Cmd>Lspsaga diagnostic_jump_prev<CR>'
    k_diag_next = '<Cmd>Lspsaga diagnostic_jump_next<CR>'
    k_diagnostics = '<Cmd>Lspsaga show_line_diagnostics<CR>'
    k_hover = '<Cmd>Lspsaga hover_doc<CR>'
    k_rename = '<Cmd>Lspsaga rename ++project<CR>'
    nmap('<space>ld', '<Cmd>Lspsaga peek_definition<CR>', 'Peek definition')
    nmap('gl', '<Cmd>Lspsaga lsp_finder<CR>', 'LSP find defintion, reference and implementation')
  end
end

local function setup_signature()
  local ok, sig = pcall(require, 'lsp_signature')
  if ok then sig.setup({
    bind = true,
    hint_prefix = '!',
    extra_trigger_chars = { '(', ',' },
  }) end
end

local function setup_lines()
  local ok, lines = pcall(require, 'lsp_lines')
  if ok then
    LspLineState = true
    local function toggle_lsp_lines()
      lines.toggle()
      LspLineState = not LspLineState
      vim.diagnostic.config({ virtual_text = LspLineState })
    end

    lines.setup()
    lines.toggle() -- disabled by default

    nmap('<leader>L', toggle_lsp_lines, 'Toggle lsp_lines')
  end
end

local function setup_vtypes()
  local ok, vtypes = pcall(require, 'virtualtypes')
  if ok then vtypes.on_attach() end
end

local function on_attach(_, _)
  setup_saga()
  setup_signature()
  setup_lines()
  setup_vtypes()
  setup_keymaps()
end

capabilities.offsetEncoding = { 'utf-16' }

require('neodev').setup({})

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
  on_attach = on_attach,
})

-- C/C++
lsp.clangd.setup({
  capabilities = capabilities,
  on_attach = function() on_attach() end,
})

-- C#
-- TODO:
-- https://github.com/Hoffs/omnisharp-extended-lsp.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/server_configurations/omnisharp/README.md
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
-- local csharp_lsp
-- if is_linux then
--   csharp_lsp = lsp.omnisharp_mono
-- else
--   csharp_lsp = lsp.omnisharp
-- end
-- csharp_lsp.setup({
--   capabilities = capabilities,
--   on_attach = function() on_attach() end,
-- })

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    require('lang.go')
    on_attach()
  end,
})

-- Haskell
lsp.hls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Java
-- TODO

-- Javascript/Typescript
lsp.eslint.setup({
  capabilities = capabilities,
})
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JSON
lsp.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua
lsp.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
  on_attach = on_attach,
})

-- Markdown
lsp.marksman.setup({
  capabilities = capabilities,
  on_attach = function()
    require('lang.markdown')
    on_attach()
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
    on_attach = function() on_attach() end,
  })
else
  -- phpactor isn't available on Windows so I'm stuck with this proprietary thing for now
  lsp.intelephense.setup({
    on_attach = function() on_attach() end,
  })
end

-- Python
lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = function()
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    on_attach()
  end,
})

-- Rust
local rt = require('rust-tools') -- this sets up rust-analyzer, so don't re-init RA which would create conflict
rt.setup({
  server = {
    capabilities = capabilities,
    on_attach = function()
      on_attach()
      rt.inlay_hints.enable()
    end,
  },
  dap = {
    adapter = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = 'rt_lldb',
    },
  },
})

-- SQL
lsp.sqlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- LaTeX
lsp.texlab.setup({
  capabilities = capabilities,
})

-- Vim
lsp.vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- YAML
lsp.yamlls.setup({
  capabilities = capabilities,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

nmap('<space>pl', '<Cmd>LspInfo<CR>')
nmap('<space>pm', '<Cmd>Mason<CR>')
