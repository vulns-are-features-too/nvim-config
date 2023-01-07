local null = require('null-ls')
local fmt = null.builtins.formatting
local diag = null.builtins.diagnostics
local comp = null.builtins.completion
local act = null.builtins.code_actions

null.setup({
  sources = {

    -- formatting
    fmt.black,
    fmt.clang_format.with({ extra_args = { '--fallback-style=Google' } }),
    fmt.gofmt,
    fmt.goimports,
    fmt.jq.with({ extra_args = { '-S' } }),
    fmt.latexindent,
    fmt.prettier,
    fmt.rustfmt,
    fmt.shellharden,
    fmt.shfmt.with({ extra_args = { '-i', '2', '-sr' } }),
    -- fmt.stylish_haskell,
    fmt.stylua,

    -- linting & diagnostics
    diag.chktex,
    diag.clang_check,
    diag.eslint,
    diag.mypy,
    diag.php,
    diag.pylint,
    diag.revive,
    diag.staticcheck,
    diag.zsh,

    -- completion
    comp.luasnip,
    comp.spell,
    comp.tags,

    -- code actions
    act.gitsigns,
    act.shellcheck,
  },
})
