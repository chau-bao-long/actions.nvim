local state = {}

ActionsGlobalState = ActionsGlobalState or {}
ActionsGlobalState.global = ActionsGlobalState.global or {}

--- Set the status for a particular prompt bufnr
function state.set_status(prompt_bufnr, status)
  ActionsGlobalState[prompt_bufnr] = status
end

function state.set_global_key(key, value)
  ActionsGlobalState.global[key] = value
end

function state.get_global_key(key)
  return ActionsGlobalState.global[key]
end

function state.get_status(prompt_bufnr)
  return ActionsGlobalState[prompt_bufnr] or {}
end

function state.clear_status(prompt_bufnr)
  state.set_status(prompt_bufnr, nil)
end

function state.get_existing_prompts()
  return vim.tbl_keys(ActionsGlobalState)
end

return state
