-- Keep the values around between reloads
_ActionsConfigurationValues = _ActionsConfigurationValues or {}

local function first_non_null(...)
  local n = select('#', ...)
  for i = 1, n do
    local value = select(i, ...)

    if value ~= nil then
      return value
    end
  end
end

local sorters = require('actions.sorters')

-- TODO: Add other major configuration points here.
-- selection_strategy

local config = {}

config.values = _ActionsConfigurationValues

function config.set_defaults(defaults)
  defaults = defaults or {}

  local function get(name, default_val)
    return first_non_null(defaults[name], config.values[name], default_val)
  end

  local function set(name, default_val)
    config.values[name] = get(name, default_val)
  end

  set("sorting_strategy", "descending")
  set("selection_strategy", "reset")
  set("scroll_strategy", nil)

  set("layout_strategy", "horizontal")
  set("layout_defaults", {})

  set("width", 0.75)
  set("winblend", 0)
  set("prompt_position", "bottom")
  set("preview_cutoff", 120)

  set("results_height", 1)
  set("results_width", 0.8)

  set("prompt_prefix", ">")

  set("border", {})
  set("borderchars", { '─', '│', '─', '│', '╭', '╮', '╯', '╰'})

  set("get_status_text", function(self) return string.format("%s / %s", self.stats.processed - self.stats.filtered, self.stats.processed) end)

  -- Builtin configuration

  -- List that will be executed.
  --    Last argument will be the search term (passed in during execution)
  set("vimgrep_arguments", {'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'})
  set("use_less", true)
  set("color_devicons", true)

  set("set_env", {})

  -- TODO: Add motions to keybindings

  -- To disable a keymap, put [map] = false
  --        So, to not map "<C-n>", just put
  --
  --            ...,
  --            ["<C-n>"] = false,
  --            ...,
  --
  --        Into your config.
  --
  -- Otherwise, just set the mapping to the function that you want it to be.
  --
  --            ...,
  --            ["<C-i>"] = actions.goto_file_selection_split
  --            ...,
  --
  set("mappings", {})
  set("default_mappings", nil)

  set("generic_sorter", sorters.get_generic_fuzzy_sorter)
  set("file_sorter", sorters.get_fuzzy_file)

  set("file_ignore_patterns", nil)
end

function config.clear_defaults()
  for k, _ in pairs(config.values) do
    config.values[k] = nil
  end
end

config.set_defaults()


return config
