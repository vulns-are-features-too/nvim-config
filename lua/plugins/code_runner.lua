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
    plantuml = 'cd $dir && plantuml $fileName',
    python = 'cd $dir && python3 -u $fileName',
    rust = 'cd $dir && rustc $fileName && ./$fileNameWithoutExt',
    sh = 'cd $dir && bash $fileName',
  },

  project_path = vim.fn.expand('~/.config/code_runner_projects.json'),
})
