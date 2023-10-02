local t = require('telescope')
local act = require('telescope.actions')
local f = require('telescope.builtin') -- builtin functions
local trouble = require('trouble.providers.telescope')
local ext = t.load_extension
local fb = t.extensions.file_browser.actions
local function map(key, target, desc, mode)
  vim.keymap.set(mode or 'n', key, target, { remap = false, silent = true, desc = desc })
end

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

    layout_strategy = 'vertical',
    layout_config = { width = 0.95, height = 0.95 }
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
local function project_files()
  local o = {}
  local ok = pcall(f.git_files, o)
  if not ok then f.find_files(o) end
end

-- configs & scripts
local function edit_config()
  require('telescope.builtin').find_files({
    search_dirs = { '~/git/dotfiles/config', '~/git/dotfiles/home', '~/git/dotfiles/shells/shared.sh' },
    hidden = true,
  })
end

local function edit_script() require('telescope.builtin').find_files({ search_dirs = { '~/git/scripts' } }) end

-- builtins
map('<space>/', f.current_buffer_fuzzy_find, 'Fuzzy find in current buffer')
map('<space>f.', f.resume, 'Telescope Resume')
map('<space>f/', f.search_history, 'Telescope search history')
map('<space>f;', f.command_history, 'Telescope command history')
map('<space>fF', f.find_files, 'Telescope find files in cwd')
map('<space>fG', f.git_status, 'Telescope git status')
map('<space>fM', f.man_pages, 'Telescope man pages')
map('<space>fT', f.builtin, 'Telescope builtins')
map('<space>fb', f.buffers, 'Telescope buffers')
map('<space>fd', f.diagnostics, 'Telescope diagnostics')
map('<space>fg', f.live_grep, 'Telescope live grep')
map('<space>fh', f.help_tags, 'Telescope help tags')
map('<space>fj', f.jumplist, 'Telescope jumplist')
map('<space>fk', f.keymaps, 'Telescope keymaps')
map('<space>fm', '<Cmd>Telescope harpoon marks<CR>', 'Telescope harpoon marks')
map('<space>fo', f.oldfiles, 'Telescope old files')
map('<space>fr', f.lsp_references, 'Telescope references')
map('<space>ft', f.tags, 'Telescope tags')
map('<space>fw', f.grep_string, 'Telescope grep word under cursor')
map('<space>fx', f.commands, 'Telescope commands', { 'n', 'v' })
map('<space>fs', f.lsp_workspace_symbols, 'Telescope workspace symbols')

-- extensions
map('<space>fB', t.extensions.file_browser.file_browser, 'Telescope file browser')
map('<space>fl', t.extensions.repo.cached_list, 'Telescope files in repos')
map('<space>fp', t.extensions.repo.list, 'Telescope repos list')
map('<space>fr', t.extensions.refactoring.refactors, 'Telescope refactoring actions', 'v')
map('<space>fy', t.extensions.neoclip.neoclip, 'Telescope yank ring')
map('<space>fz', t.extensions.zoxide.list, 'Telescope zoxide jump list')

-- my functions
map('<space>fc', edit_config, 'Telescope edit config')
map('<space>ff', project_files, 'Telescope project files')
map('<space>fX', edit_script, 'Telescope edit scripts')
