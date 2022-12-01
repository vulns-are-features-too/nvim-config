vim.g.ale_disable_lsp = 0
vim.g.ale_linters = {
  python = { 'pylint' },
  java = { 'eclipselsp' },
  rust = { 'analyzer' },
}
