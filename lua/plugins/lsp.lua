local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local is_linux = vim.fn.has('linux') == 1 or vim.fn.has('unix') == 1
local on_attach_ran = false
local g = vim.g

local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, desc = desc }) end

local function nvmap(key, target, desc) vim.keymap.set({ 'n', 'v' }, key, target, { remap = false, desc = desc }) end

local function toggle_inlay_hints() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end

-- keymap targets
local k_actions = vim.lsp.buf.code_action
local k_rename = vim.lsp.buf.rename
local k_diagnostics = vim.diagnostic.open_float
local k_diag_next = function() vim.diagnostic.jump({count = 1}) end
local k_diag_prev = function() vim.diagnostic.jump({count = -1}) end
local k_hover = vim.lsp.buf.hover

local function setup_keymaps()
  nmap('K', k_hover, 'Signature hover')
  nmap('H', vim.lsp.buf.signature_help, 'Signature help')
  nmap('<leader>f', vim.lsp.buf.format, 'Format')
  nmap('<space><space>f', vim.lsp.buf.format, 'Format')
  nmap('<space>e', k_diagnostics, 'Line diagnostics')
  nmap('[e', k_diag_prev, 'Go to previous diagnostics')
  nmap(']e', k_diag_next, 'Go to next diagnostics')
  nmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
  nmap('gd', vim.lsp.buf.definition, 'Go to definition')
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
  nmap('gt', vim.lsp.buf.type_definition, 'Go to type definition')
  nmap('<space>rr', k_rename, 'Rename')
  nvmap('<space>a', k_actions, 'Code action')
  nmap('<leader>h', toggle_inlay_hints, 'Toggle inlay hints')
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
      outline = {
        keys = {
          expand_or_jump = '<CR>',
          quit = 'q',
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
    nmap('<space>lo', '<Cmd>Lspsaga outline<CR>', 'LSP outline')
    nmap('gl', '<Cmd>Lspsaga lsp_finder<CR>', 'LSP find defintion, reference and implementation')
  end
end

local function setup_signature()
  local ok, sig = pcall(require, 'lsp_signature')
  if ok then
    sig.setup({
      bind = true,
      hint_prefix = '!',
      extra_trigger_chars = { '(', ',' },
    })
  end
end

local function setup_vtypes()
  local ok, vtypes = pcall(require, 'virtualtypes')
  if ok then vtypes.on_attach() end
end

local function on_attach(_, _)
  if on_attach_ran then return end
  setup_saga()
  setup_signature()
  setup_vtypes()
  setup_keymaps()
  on_attach_ran = true
end

capabilities.offsetEncoding = { 'utf-16' }

-- Bash
lsp.bashls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- C/C++
lsp.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- C#
lsp.omnisharp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'dotnet', vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll' },
  handlers = {
    ['textDocument/definition'] = require('omnisharp_extended').handler,
  },
  settings = {
    FormattingOptions = {
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      EnableEditorConfigSupport = true,
      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      OrganizeImports = true,
    },
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = true,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = true,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = true,
      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      AnalyzeOpenDocumentsOnly = nil,
    },
  },
})

-- Go
lsp.gopls.setup({
  capabilities = capabilities,
  on_attach = function(_, _)
    g.go_fmt_command = 'goimports'
    g.go_highlight_types = 1
    g.go_highlight_fields = 1
    g.go_highlight_functions = 1
    g.go_highlight_function_calls = 1
    g.go_highlight_extra_types = 1
    g.go_metalinter_enabled = { 'vet', 'golint', 'errcheck' }
    on_attach()
  end,
})
lsp.templ.setup({
  capabilities = capabilities,
})

-- HTML/HTMX
lsp.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lsp.htmx.setup({
  capabilities = capabilities,
})

-- Javascript/Typescript
lsp.eslint.setup({
  capabilities = capabilities,
})
lsp.ts_ls.setup({
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
  on_attach = on_attach,
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
      hint = { enable = true },
      telemetry = { enable = false },
    },
  },
})

-- Markdown
lsp.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- PHP
lsp.psalm.setup({})
if is_linux then
  lsp.phpactor.setup({
    init_options = {
      ['language_server_phpstan.enabled'] = true,
      ['language_server_psalm.enabled'] = true,
    },
    capabilities = capabilities,
    on_attach = on_attach,
  })
else
  -- phpactor isn't available on Windows so I'm stuck with this proprietary thing for now
  lsp.intelephense.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- Powershell
local pses_path = vim.fn.stdpath('data')
    .. '/mason/packages/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1'
lsp.powershell_es.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'pwsh', '-NoLogo', '-NoProfile', '-Command', pses_path },
})

-- Python
lsp.pylsp.setup({
  capabilities = capabilities,
  on_attach = function()
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    on_attach()
  end,
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        mypy = { enabled = true },
        rope = { enabled = true },
        ruff = { enabled = true },
      },
    },
  },
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
  on_attach = on_attach,
})

-- Vim
lsp.vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- YAML
lsp.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

nmap('<space>pl', '<Cmd>LspInfo<CR>')
nmap('<space>pr', '<Cmd>LspRestart<CR>')
nmap('<space>pm', '<Cmd>Mason<CR>')
nmap('<space>pn', '<Cmd>NullLsInfo<CR>')
