require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    changedelete = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '-' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },

  -- mappings
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc, opts)
      opts = opts or { remap = false }
      opts.buffer = bufnr
      opts.desc = desc
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']g', function()
      if vim.wo.diff then return ']g' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, 'Next git hunk', { expr = true })

    map('n', '[g', function()
      if vim.wo.diff then return '[g' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, 'Previous git hunk', { expr = true })

    -- Actions
    map('n', '<leader>gB', gs.toggle_current_line_blame, 'Git toggle current line blame')
    map('n', '<leader>gD', gs.toggle_deleted, 'Git toggle current line blame')
    map('n', '<leader>gR', gs.reset_buffer, 'Git reset buffer')
    map('n', '<leader>gS', gs.stage_buffer, 'Git stage bufer')
    map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Git blame line')
    map('n', '<leader>gd', gs.diffthis, 'Git diff this')
    map('n', '<space>gU', gs.undo_stage_hunk, 'Git undo stage hunk')
    map('n', 'gs', gs.preview_hunk, 'Git preview hunk')
    map({ 'n', 'v' }, '<space>gs', ':Gitsigns stage_hunk<CR>', 'Git stage hunk')
    map({ 'n', 'v' }, '<space>gu', ':Gitsigns reset_hunk<CR>', 'Git undo/reset hunk')

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git hunk object')
  end,
})
