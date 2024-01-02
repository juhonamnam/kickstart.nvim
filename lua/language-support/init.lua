local init = function()
  require('mason').setup()
  require('language-support.lsp').init()
end

-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
  -- LSP Configuration & Plugins
  'williamboman/mason.nvim',
  dependencies = {
    require("language-support.formatter"),
    unpack(require("language-support.lsp").dependencies),
  },
  init = init,
}
