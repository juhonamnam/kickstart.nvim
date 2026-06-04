do
  vim.pack.add { 'https://github.com/nvim-tree/nvim-tree.lua' }
  vim.pack.add { 'https://github.com/nvim-tree/nvim-web-devicons' }

  -- Configure nvim-tree
  local nvim_tree_on_attach = function(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

    -- default mappings
    api.map.on_attach.default(bufnr)

    -- custom mappings
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
  end

  require('nvim-tree').setup {
    on_attach = nvim_tree_on_attach,
  }

  -- nvim-tree keymap
  require('which-key').add {
    { '<leader>e', group = '[E]xplorer' },
    { '<leader>e_', hidden = true },
  }
  vim.keymap.set('n', '<leader>et', ':NvimTreeToggle<CR>', { desc = '[E]xplorer [T]oggle' })
  vim.keymap.set('n', '<leader>ef', ':NvimTreeFocus<CR>', { desc = '[E]xplorer [F]ocus' })
  vim.keymap.set('n', '<leader>er', ':NvimTreeRefresh<CR>', { desc = '[E]xplorer [R]efresh' })

  require('nvim-web-devicons').setup {}
end
