local g = vim.g
g.go_fmt_command = 'goimports'
g.go_highlight_types = 1
g.go_highlight_fields = 1
g.go_highlight_functions = 1
g.go_highlight_function_calls = 1
g.go_highlight_extra_types = 1
g.go_metalinter_enabled = { 'vet', 'golint', 'errcheck' }
