local rt = require('rust-tools')
local map = vim.keymap.set
local nmap = function(key, target, opts) map('n', key, target, opts) end

vim.b.dispatch = 'cargo build'
vim.opt_local.tags = './rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi'
vim.cmd([[silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!]])

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      nmap('<leader>a', rt.hover_actions.hover_actions, { buffer = bufnr })
      nmap('<leader>A', rt.code_action_group.code_action_group, { buffer = bufnr })
      nmap('<leader>m', rt.expand_macro.expand_macro, { buffer = bufnr })
    end,
  },

  -- debugging stuff
  dap = {
    adapter = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = 'rt_lldb',
    },
  },
})

rt.inlay_hints.enable()
