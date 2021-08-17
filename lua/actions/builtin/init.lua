--[[
A collection of builtin pipelines for telesceope.

Meant for both example and for easy startup.

Any of these functions can just be called directly by doing:

:lua require('actions.builtin').__name__()

This will use the default configuration options.
  Other configuration options still in flux at the moment
--]]

if 1 ~= vim.fn.has('nvim-0.5') then
  vim.api.nvim_err_writeln("This plugins requires neovim 0.5")
  vim.api.nvim_err_writeln("Please update your neovim.")
  return
end

if 2 > vim.o.report then
  vim.api.nvim_err_writeln(string.format("[actions] It seems you have `set report=%s`", vim.o.report))
  vim.api.nvim_err_writeln("[actions] Instead, change 'report' back to its default value. `set report=2`.")
  vim.api.nvim_err_writeln("[actions] If you do not, you will have a bad experience")
end


local actions = require('actions.actions')
local finders = require('actions.finders')
local pickers = require('actions.pickers')
local previewers = require('actions.previewers')
local sorters = require('actions.sorters')
local utils = require('actions.utils')

local builtin = {}

builtin.actions = function(opts)
  utils.data_by_filetype(opts)

  local results = {}
  local actionsInLua = vim.api.nvim_get_var(opts.data)

  for i = 1, #actionsInLua do
    table.insert(results, actionsInLua[i][1])
  end

  pickers.new(opts, {
      prompt_title = 'Pick your actions',
      finder = finders.new_table(results),
      sorter = sorters.get_fzy_sorter(),
      previewer = previewers.actions.new(opts),
      attach_mappings = function(prompt_bufnr, map)
        local execute = function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          for i = 1, #actionsInLua do
            if actionsInLua[i][1] == selection.value then
              actions.close(prompt_bufnr)
              vim.cmd(actionsInLua[i][2])
              break
            end
          end
        end

        map('i', '<CR>', execute)
        map('n', '<CR>', execute)

        return true
      end,
    }):find()
end

return builtin
