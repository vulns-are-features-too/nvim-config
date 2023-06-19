local neotest = require('neotest')
local function nmap(key, target, desc) vim.keymap.set('n', key, target, { remap = false, desc = desc }) end

neotest.setup({
  adapters = {
    require('neotest-playwright').adapter({
      options = {
        persist_project_selection = true,
        enable_dynamic_test_discovery = true,
        get_playwright_binary = function() return vim.loop.os_homedir() .. "/AppData/Roaming/npm/playwright" end
      },
    }),
  },
})

nmap('<space>t.', function() neotest.run.stop() end, 'Stop tests')
nmap('<space>ta', function() neotest.run.run() end, 'Run all tests')
nmap('<space>tf', function() neotest.run.run(vim.fn.expand('%')) end, 'Run tests for current file')
nmap('<space>tF', function() neotest.run.run({ vim.fn.expand('%'), strategy = 'dap' }) end, 'Debug tests for current file')
nmap('<space>to', function() neotest.output.open() end, 'Show test output')
nmap('<space>tr', function() neotest.run.run_last({ strategy = 'dap' }) end, 'Rerun and debug last test')
nmap('<space>ts', function() neotest.summary.toggle() end, 'Toggle test summary')
nmap('<space>tt', function() neotest.run.run({ strategy = 'dap' }) end, 'Run nearest test')
nmap('[t', function() neotest.jump.prev({ status = 'failed' }) end, 'Prev failed test')
nmap(']t', function() neotest.jump.prev({ status = 'failed' }) end, 'Next failed test')
