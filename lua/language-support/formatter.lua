return {
  dep = 'mhartington/formatter.nvim',
  init = function()
    vim.keymap.set('n', '<leader>ff', ':Format<CR>', { desc = '[F]ormatter [F]ormat' })

    local registry = require 'mason-registry'

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require('formatter').setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,

      filetype = {
        ['*'] = {
          function()
            local modname = 'formatter.filetypes.' .. vim.bo.filetype

            local formatters
            local installed_formatters = {}

            if pcall(function()
              formatters = require(modname)
            end) then
              for name, func in pairs(formatters) do
                local installed = registry.is_installed(name)
                if installed then
                  table.insert(installed_formatters, { name = name, func = func })
                end
              end
            end

            local count = #installed_formatters

            local selected_formatter

            if count == 1 then
              selected_formatter = installed_formatters[1]
            elseif count > 1 then
              local msg = ''
              for idx, f in pairs(installed_formatters) do
                msg = msg .. idx .. ') ' .. f.name .. '\n'
              end
              local i = vim.fn.input('select formatter\n' .. msg)
              print '\n'
              local idx = tonumber(i)
              selected_formatter = installed_formatters[idx]
            end

            if selected_formatter ~= nil then
              print('Format with ' .. selected_formatter.name)
              return selected_formatter.func()
            else
              print 'Formatter not found'
            end
          end,
        },
      },
    }
  end,
}
