local config = function()
  local conform = require('conform')

  conform.setup {
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
    }
  }

  vim.keymap.set('n', '<leader>ff', function()
    conform.format({ async = false, lsp_fallback = true })
  end, { desc = '[F]ormatter [F]ormat' }
  )
end

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = config
}
