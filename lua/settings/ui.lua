local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local function au(event, func) vim.api.nvim_create_autocmd(event, { pattern = '*', callback = func }) end

-- highlight on yank
au('TextYankPost', function() vim.highlight.on_yank({ timeout = 300 }) end)

-- theme
vim.g.gruvbox_italic = 1
vim.g.gruvbox_invert_signs = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = 0
vim.cmd.colorscheme 'gruvbox'

-- quick-scope
hl('QuickScopePrimary', { fg = '#afff5f', underline = true, ctermfg = 155, cterm = { underline = true } })
hl('QuickScopeSecondary', { fg = '#5fffff', underline = true, ctermfg = 81, cterm = { underline = true } })

-- nvim-cmp
local hl_deprecated = { bg = nil, strikethrough = true, fg = '#808080' } -- deprecated - gray
local hl_match = { bg = nil, fg = '#569cd6', underline = true } -- match - blue
local hl_var = { bg = nil, fg = '#9cdcfe' } -- text & variables - light blue
local hl_func = { bg = nil, fg = '#c586c0', italic = true } -- functions & methods - pink
local hl_param = { bg = nil, fg = '#d4d4d4', underline = true } -- fields and params
local hl_class = { bg = nil, fg = '#9cdcfe', bold = true } -- enums, classes, & interfaces
local hl_pkg = { bg = nil, fg = '#d4d4d4', bold = true } -- modules & packages
local hl_snippet = { bg = nil, fg = '#d4d4d4' } -- snippets
local hl_misc = { bg = nil, fg = '#d4d4d4' } -- undecided

hl('CmpItemAbbrDeprecated', hl_deprecated)

hl('CmpItemAbbrMatch', hl_match)
hl('CmpItemAbbrMatchFuzzy', hl_match)

hl('CmpItemKindConstant', hl_var)
hl('CmpItemKindFile', hl_var)
hl('CmpItemKindFolder', hl_var)
hl('CmpItemKindText', hl_var)
hl('CmpItemKindValue', hl_var)
hl('CmpItemKindVariable', hl_var)

hl('CmpItemKindConstructor', hl_func)
hl('CmpItemKindFunction', hl_func)
hl('CmpItemKindMethod', hl_func)

hl('CmpItemKindEnumMember', hl_param)
hl('CmpItemKindField', hl_param)
hl('CmpItemKindProperty', hl_param)
hl('CmpItemKindStruct', hl_param)
hl('CmpItemKindTypeParameter', hl_param)

hl('CmpItemKindClass', hl_class)
hl('CmpItemKindEnum', hl_class)
hl('CmpItemKindInterface', hl_class)

hl('CmpItemKindModule', hl_pkg)

hl('CmpItemKindSnippet', hl_snippet)

hl('CmpItemKindEvent', hl_misc)
hl('CmpItemKindKeyword', hl_misc)
hl('CmpItemKindReference', hl_misc)
hl('CmpItemKindUnit', hl_misc)
