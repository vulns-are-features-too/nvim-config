-- Highlight code inside Markdown
vim.g.markdown_fenced_languages = {
  'bash',
  'c',
  'cpp',
  'go',
  'html',
  'java',
  'javascript',
  'json',
  'php',
  'python',
  'rust',
  'sh',
  'sql',
  'toml',
  'yaml',
}

-- vim-markdown-toc
vim.g.vmt_auto_update_on_save = 1
vim.g.vmt_fence_text = 'TOC'
vim.g.vmt_fence_closing_text = '\\TOC'
vim.g.vmt_cycle_list_item_markers = 1

-- vim-polyglot
vim.g.vim_markdown_new_list_item_indent = 0
