local api = vim.api
local dap = require('dap')
local ui = require('dapui')

local map = vim.keymap.set
local function nmap(key, target, desc) map('n', key, target, { remap = false, silent = true, desc = desc }) end
local function vmap(key, target, desc) map('v', key, target, { remap = false, silent = true, desc = desc }) end

---- Rust/C/C++ ----
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb',
}
dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

---- bash ----
dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb',
}
dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = 'Launch file',
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    trace = true,
    file = '${file}',
    program = '${file}',
    cwd = '${workspaceFolder}',
    pathCat = 'cat',
    pathBash = '/bin/bash',
    pathMkfifo = 'mkfifo',
    pathPkill = 'pkill',
    args = {},
    env = {},
    terminalKind = 'integrated',
  },
}

---- DAP UI ----
-- Don't list the [dap-repl] buffer by default
api.nvim_create_autocmd('FileType', {
  pattern = 'dap-repl',
  callback = function(args) vim.api.nvim_buf_set_option(args.buf, 'buflisted', false) end,
})

ui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = '<CR>',
    open = 'o',
    remove = 'd',
    edit = 'e',
    repl = 'r',
    toggle = 't',
  },
  -- Expand lines larger than the window
  expand_lines = true,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = 'scopes', size = 0.25 },
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40, -- 40 columns
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 0.25, -- 25% of total lines
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = 'single', -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  },
})

dap.listeners.before.attach.dapui_config = ui.open
dap.listeners.before.launch.dapui_config = ui.open
dap.listeners.before.event_terminated.dapui_config = ui.close
dap.listeners.before.event_exited.dapui_config = ui.close

---- Virtual text ----
require('nvim-dap-virtual-text').setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = true, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

---- keymaps ----

-- K evals word under cursor while debugging
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == 'K' then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end
dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
  end
  keymap_restore = {}
end

nmap('<F5>', dap.continue, 'DAP continue')
nmap('dc', dap.continue, '[D]ebug [C]ontinue')
nmap('<F6>', dap.step_into, 'DAP step into')
nmap('dx', dap.step_into, '[D]ebug e[X]it (step into)')
nmap('<F7>', dap.step_over, 'DAP step over')
nmap('d<space>', dap.step_over, '[D]ebug next (step over)')
nmap('<F8>', dap.step_out, 'DAP step out')
nmap('dy', dap.step_out, '[D]ebug [Y]eet (step out)')
nmap('<space>db', dap.toggle_breakpoint, '[D]ebug [B]reakpoint')
nmap('<space>dB', function() dap.set_breakpoint(vim.fn.input('Break condition: ')) end, '[D]ebug [B]reak conditional')
vmap('<space>de', function() ui.eval() end, '[D]ebug [E]val')
nmap('<leader>du', function() ui.toggle() end, '[D]ebug [U]I')
