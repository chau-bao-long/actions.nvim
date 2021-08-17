# Actions.nvim
Sometimes, we feel hard to remember all the hotkeys, especially the keys we rarely use.
Actions.nvim is the plugin that allow you to create a list of actions, by fuzzy searching through the actions, you can run it without remember the keybinding.

## Getting Started

#### Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'chau-bao-long/actions.nvim'
```

#### Usage

Build your custom maps
```viml

" Actions only for kotlin filetype
let g:kotlinActions = [
      \ ['💾 ktlint', 'tabnew | terminal ktlint'],
      \ ['💾 run all test', 'tabnew | terminal ./gradlew cleanTest test --info'],
      \ ['💾 build', 'tabnew | terminal ./gradlew build'],
      \ ['💾 bootJar', 'tabnew | terminal ./gradlew bootJar'],
      \ ['💾 compile', 'tabnew | terminal ./gradlew compileKotlin'],
      \ ['💾 clean', 'tabnew | terminal ./gradlew clean'],
      ...
      \]

" Actions only for javascript filetype
let g:javascriptActions = [
      \ ['💾 eslint all file', 'Dispatch pwd | xargs eslint'],
      \ ['💾 eslint current file', 'Dispatch! eslint %:p'],
      \ ['💾 eslint fix all file', 'Dispatch pwd | xargs eslint --fix'],
      \ ['💾 prettier all file', 'Dispatch yarn prettier'],
      \ ['💾 prettier current file', 'Dispatch! prettier --write %:p'],
      ...
      \]

" Actions only for php filetype, and so on
let g:phpActions = [ ... ]

" Common actions for every filetype
let g:commonActions = [
  ...

  \]

" Secret actions (like: database creds)"
let g:databases = [
      \ ['📄 db monolith', 'DB g:cur = mysql://root:root@dev.test.de:30601/db'],
      \ ['📄 adhoc monolith', 'tabnew | terminal mycli -u root -h admin.dev.db.de -P 30601 -p"root" -D db' ],
      \ ['📄 first service', 'DB g:cur = postgres://postgres:postgres@dev.db.de:30781/first-service-db'],
      \ ['📄 adhoc first service', 'tabnew | terminal PGPASSWORD=postgres pgcli -h dev.db.de -p 30781 -U postgres first-service-db' ],
      \ ['📄 second service', 'DB g:cur = postgres://postgres:postgres@dev.db.de:30681/second-db'],
      ...
  \]

```

```viml
" Take actions from g:commonActions variable
nnoremap <space><space> :lua require'actions.builtin'.actions(require('actions.themes').get_dropdown({ winblend = 10, data = 'commonActions' }))<cr>

" Take actions from g:databases
nnoremap <space>se :lua require'actions.builtin'.actions(require('actions.themes').get_dropdown({ winblend = 10, data = 'databases' }))<cr>

" Take actions base on file type, g:kotlinActions for kotlin filetype, g:phpActions for php filetype, g:XXXActions for XXX filetype
nnoremap <space>k :lua require'actions.builtin'.actions(require('actions.themes').get_dropdown({ winblend = 10, data = 'fromFileType' }))<cr>
```

## Contributing

All contributions are welcome! Just open a pull request.
<!-- TODO: add plugin documentation -->
When approved,
  changes in the user interface and new built-in functions
  will need to be reflected in the documentation and in `README.md`.
