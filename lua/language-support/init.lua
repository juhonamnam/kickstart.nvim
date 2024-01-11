local lsp = require 'language-support.lsp'
local formatter = require 'language-support.formatter'

local init = function()
  require('mason').setup()
  lsp.init()
  formatter.init()
end

-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
  -- LSP Configuration & Plugins
  'williamboman/mason.nvim',
  dependencies = {
    lsp.dep,
    formatter.dep,
  },
  init = init,
}
