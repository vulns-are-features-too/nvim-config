FullFeature = FullFeature or true

vim.cmd([[
runtime general.vim
]])

if FullFeature then
  require('plugins.plugins')
  require('settings')
end
