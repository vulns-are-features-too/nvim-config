local g = vim.g

g.rooter_change_directory_for_non_project_files = 'current'
g.rooter_manual_only = 1
g.rooter_cd_cmd = 'lcd'
g.rooter_resolve_links = 1

vim.keymap.set('n', 'g/', '<Cmd>Rooter<CR>', { remap = false, silent = true, desc = 'Go to project root' })
