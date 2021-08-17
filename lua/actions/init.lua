require('actions._compat')

local _extensions = require('actions._extensions')

local actions = {}

function actions.setup(opts)
  opts = opts or {}

  if opts.default then
    error("'default' is not a valid value for setup. See 'defaults'")
  end

  require('actions.config').set_defaults(opts.defaults)
  _extensions.set_config(opts.extensions)
end

function actions.register_extension(mod)
  return _extensions.register(mod)
end

function actions.load_extension(name)
  return _extensions.load(name)
end

--- Use actions.extensions to reference any extensions within your configuration.
actions.extensions = require('actions._extensions').manager

return actions
