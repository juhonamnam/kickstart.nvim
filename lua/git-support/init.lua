return {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
  },
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview [G]it [H]unk' })
      vim.keymap.set('n', '<leader>gs', ':Gdiffsplit<CR>', { buffer = bufnr, desc = '[G]it Diff [S]plit' })
      vim.keymap.set('n', '<leader>gt', require('gitsigns').toggle_current_line_blame, { buffer = bufnr, desc = '[G]it [T]oggle Current Line Blame' })

      -- don't override the built-in and fugitive keymaps
      local gs = package.loaded.gitsigns
      vim.keymap.set({ 'n', 'v' }, ']h', function()
        if vim.wo.diff then
          return ']h'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
      vim.keymap.set({ 'n', 'v' }, '[h', function()
        if vim.wo.diff then
          return '[h'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
    end,
  },
}
