local nmap = function(key, target) vim.keymap.set('n', key, target, { remap = false }) end

require('code_runner').setup({
  mode = 'float',
  float = {
    border = 'double',
  },

  filetype = {
    c = 'cd $dir && gcc $fileName -o $fileNameWithoutExt',
    cpp = 'cd $dir && g++ $fileName -o $fileNameWithoutExt',
    go = 'cd $dir && go run $fileName',
    java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
    python = 'cd $dir && python3 -u $fileName',
    rust = 'cd $dir && rustc $fileName && ./$fileNameWithoutExt',
    sh = 'cd $dir && bash $fileName',
  },

  project_path = vim.fn.expand('~/.config/code_runner_projects.json'),
})
--
-- code_runner.nvim
nmap('<leader>rr', '<Cmd>RunCode<CR>')
nmap('<leader>rf', '<Cmd>RunFile<CR>')
nmap('<leader>rp', '<Cmd>RunProject<CR>')
nmap('<leader>rc', '<Cmd>RunClose<CR>')
