local telescope = require('telescope')
local act = require('telescope.actions')
local builtin = require('telescope.builtin')
local ext = telescope.load_extension

local fzf_opts = {
  fuzzy = true,
  override_generic_sorter = true,
  override_file_sorter = true,
  case_mode = 'smart_case',
}

local fb = telescope.extensions.file_browser.actions
local file_browser_opts = {
  hijack_netrw = true,
  mappings = {
    ['i'] = {
      ['<S-CR>'] = fb.create_from_prompt,
    },
    ['n'] = {
      ['a'] = fb.create,
      ['c'] = fb.rename,
      ['y'] = fb.copy,
      ['m'] = fb.move,
      ['d'] = fb.remove,
      ['o'] = fb.open,
      ['h'] = fb.goto_parent_dir,
      ['gh'] = fb.goto_home_dir,
      ['g.'] = fb.goto_cwd,
      ['gd'] = fb.change_cwd,
      ['zz'] = fb.toggle_hidden,
      ['<C-a>'] = fb.toggle_all,
    },
  },
}

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-q>'] = act.send_to_qflist + act.open_qflist,
      },
    },
  },

  extensions = {
    fzf = fzf_opts,
    file_browser = file_browser_opts,
  },

  dynamic_preview_title = true,
})

ext('dap')
ext('file_browser')
ext('fzf')
ext('neoclip')
ext('notify')
ext('projects')

-- git_files falling back to find_files if not in a git repo
Project_files = function()
  local o = {}
  local ok = pcall(builtin.git_files, o)
  if not ok then builtin.find_files(o) end
end
