
return require('plenary.log').new {
  plugin = 'actions',
  level = (vim.loop.os_getenv("USER") == 'tj' and 'debug') or 'warn',
}
