do
  vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }
  vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    on_attach = function(bufnr)
      require('which-key').add {
        { '<leader>g', group = '[G]it' },
        { '<leader>g_', hidden = true },
      }
      vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview [G]it [H]unk' })
      vim.keymap.set('n', '<leader>gs', ':Gdiffsplit<CR>', { buffer = bufnr, desc = '[G]it Diff [S]plit' })
      vim.keymap.set('n', '<leader>gt', require('gitsigns').toggle_current_line_blame, { buffer = bufnr, desc = '[G]it [T]oggle Current Line Blame' })

      local gs = package.loaded.gitsigns
      vim.keymap.set({ 'n', 'v' }, ']h', function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
      vim.keymap.set({ 'n', 'v' }, '[h', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
    end,
  }
end
