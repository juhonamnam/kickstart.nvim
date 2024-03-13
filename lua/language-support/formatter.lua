local M = {}

M.dep = 'mhartington/formatter.nvim'

local function check_file_exists(name)
  local f = io.open(name, 'r')
  return f ~= nil and io.close(f)
end

local filetypes_override = {
  scss = function(_)
    return {
      prettier = require('formatter.util').withl(require 'formatter.defaults.prettier', 'scss'),
    }
  end,
}

local formatters_override = {
  prettier = function(orig_command)
    local is_local_yarn = check_file_exists '.yarn/sdks/prettier/index.js'

    if is_local_yarn then
      orig_command.exe = 'yarn prettier'
    end

    return orig_command
  end,
}

function M.init()
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

          pcall(function()
            formatters = require(modname)
          end)

          if filetypes_override[vim.bo.filetype] ~= nil then
            formatters = filetypes_override[vim.bo.filetype](formatters)
          end

          for name, func in pairs(formatters) do
            local installed = registry.is_installed(name)
            if installed then
              table.insert(installed_formatters, { name = name, func = func })
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
            local command = selected_formatter.func()

            if formatters_override[selected_formatter.name] ~= nil then
              command = formatters_override[selected_formatter.name](command)
            end

            if command ~= nil then
              print('Format with ' .. selected_formatter.name)
              return command
            end

            print 'Formatter not found'
          else
            print 'Formatter not found'
          end
        end,
      },
    },
  }
end

return M
