local t = require('telescope')
local act = require('telescope.actions')
local f = require('telescope.builtin') -- builtin functions
local trouble = require('trouble.providers.telescope')
local ext = t.load_extension
local fb = t.extensions.file_browser.actions
local map = function(key, target, mode) vim.keymap.set(mode or 'n', key, target, { remap = false, silent = true }) end

-- setup

local fzf_opts = {
  fuzzy = true,
  override_generic_sorter = true,
  override_file_sorter = true,
  case_mode = 'smart_case',
}

local file_browser_opts = {
  hijack_netrw = true,
  mappings = {
    ['i'] = {
      ['<S-CR>'] = fb.create_from_prompt,
      ['<C-CR>'] = fb.create_from_prompt,
    },
    ['n'] = {
      ['n'] = fb.create,
      ['r'] = fb.rename,
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

local repo_opts = {
  list = {
    fd_opts = {
      '--hidden',
      '--follow',
    },
    search_dirs = {
      '~/git',
    },
  },
  cached_list = { file_ignore_patterns = { '/%.cache/', '/%.cargo/', '/node_modules/' } },
}

t.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = act.select_horizontal,
        ['<C-k>'] = act.select_vertical,
        ['<C-u>'] = false,
        ['<C-t>'] = trouble.smart_open_with_trouble,
      },
      n = {
        ['<C-j>'] = act.select_horizontal,
        ['<space>j'] = act.select_horizontal,
        ['<C-k>'] = act.select_vertical,
        ['<space>k'] = act.select_vertical,
        ['<C-t>'] = trouble.smart_open_with_trouble,
        ['<space>t'] = trouble.smart_open_with_trouble,
      },
    },
  },

  extensions = {
    fzf = fzf_opts,
    file_browser = file_browser_opts,
    repo = repo_opts,
  },

  dynamic_preview_title = true,
})

-- extensions
ext('dap')
ext('file_browser')
ext('fzf')
ext('harpoon')
ext('neoclip')
ext('notify')
ext('refactoring')
ext('repo')
ext('zoxide')

-- keymaps

-- git_files falling back to find_files if not in a git repo
local project_files = function()
  local o = {}
  local ok = pcall(f.git_files, o)
  if not ok then f.find_files(o) end
end
-- configs & scripts
local edit_config = function()
  require('telescope.builtin').find_files({
    search_dirs = { '~/git/dotfiles/config', '~/git/dotfiles/home', '~/git/dotfiles/shells/shared.sh' },
    hidden = true,
  })
end
local edit_script = function() require('telescope.builtin').find_files({ search_dirs = { '~/git/scripts' } }) end

-- builtins
map('<space>/', f.current_buffer_fuzzy_find)
map('<space>f.', f.resume)
map('<space>f/', f.search_history)
map('<space>f;', f.command_history)
map('<space>fF', f.find_files)
map('<space>fG', f.git_status)
map('<space>fM', f.man_pages)
map('<space>fT', f.builtin)
map('<space>fb', f.buffers)
map('<space>fd', f.diagnostics)
map('<space>fg', f.live_grep)
map('<space>fh', f.help_tags)
map('<space>fj', f.jumplist)
map('<space>fk', f.keymaps)
map('<space>fm', '<Cmd>Telescope harpoon marks<CR>')
map('<space>fo', f.oldfiles)
map('<space>fr', f.lsp_references)
map('<space>ft', f.tags)
map('<space>fw', f.grep_string)
map('<space>fx', f.commands, { 'n', 'v' })

-- extensions
map('<space>fB', t.extensions.file_browser.file_browser)
map('<space>fl', t.extensions.repo.cached_list)
map('<space>fp', t.extensions.repo.list)
map('<space>fr', t.extensions.refactoring.refactors, 'v')
map('<space>fy', t.extensions.neoclip.neoclip)
map('<space>fz', t.extensions.zoxide.list)

-- my functions
map('<space>fc', edit_config)
map('<space>ff', project_files)
map('<space>fs', edit_script)
