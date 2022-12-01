require('luasnip.loaders.from_snipmate').lazy_load()

require('luasnip').config.set_config({
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})
