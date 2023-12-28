local req = function(language, lua_file)
  local src = lua_file or language
  vim.api.nvim_create_autocmd('Filetype', { pattern = language, callback = function() require('lang.' .. src) end })
end

req('rust')
req('go')
req('java')
