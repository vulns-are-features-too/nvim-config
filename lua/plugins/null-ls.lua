local null = require('null-ls')
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics
local comp = null.builtins.completion
local act = null.builtins.code_actions

null.setup({
  sources = {

    -- formatting
    fmt.gofmt,
    fmt.goimports,
    fmt.jq.with({ extra_args = { '-S' } }),
    fmt.latexindent,
    fmt.prettier,
    fmt.shellharden,
    fmt.shfmt.with({ extra_args = { '-i', '2', '-sr' } }),
    fmt.sqlfluff.with({ extra_args = { '--dialect', 'mysql' } }),
    fmt.stylua,

    -- linting & diagnostics
    diag.chktex,
    diag.php,
    diag.phpstan,
    diag.revive,
    diag.sqlfluff.with({ extra_args = { '--dialect', 'mysql' } }),
    diag.staticcheck,
    diag.zsh,

    -- completion
    comp.luasnip,
    comp.spell,
    comp.tags,

    -- code actions
    act.gitsigns,
    act.refactoring,
    act.shellcheck,
  },
})
