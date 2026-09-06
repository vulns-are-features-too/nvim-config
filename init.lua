FullFeature = FullFeature or true

vim.env.GIT_DEFAULT_REF_FORMAT = "files"

vim.cmd([[
runtime general.vim
]])

if FullFeature then
  require('plugins.plugins')
  require('settings')
end
