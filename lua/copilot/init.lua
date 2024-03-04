return {
  'github/copilot.vim',
  init = function()
    vim.keymap.set('n', '<leader>cs', ':Copilot setup<CR>', { desc = '[C]opilot [S]etup' })
    vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[C]opilot [E]nable' })
    vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[C]opilot [D]isable' })
  end,
}
