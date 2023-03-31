require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    changedelete = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '-' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
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
    col = 1,
  },
  yadm = {
    enable = false,
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
    map('n', '<leader>gB', 'Git toggle current line blame', gs.toggle_current_line_blame)
    map('n', '<leader>gD', 'Git toggle current line blame', gs.toggle_deleted)
    map('n', '<leader>gR', 'Git reset buffer', gs.reset_buffer)
    map('n', '<leader>gS', 'Git stage bufer', gs.stage_buffer)
    map('n', '<leader>gb', 'Git blame line', function() gs.blame_line({ full = true }) end)
    map('n', '<leader>gd', 'Git diff this', gs.diffthis)
    map('n', '<space>gU', 'Git undo stage hunk', gs.undo_stage_hunk)
    map('n', 'gs', 'Git preview hunk', gs.preview_hunk)
    map({ 'n', 'v' }, '<space>gs', ':Gitsigns stage_hunk<CR>', 'Git stage hunk')
    map({ 'n', 'v' }, '<space>gu', ':Gitsigns reset_hunk<CR>', 'Git undo/reset hunk')

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git hunk object')
  end,
})
