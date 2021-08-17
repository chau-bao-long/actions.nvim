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

Example in Lua
```lua
vim.g.commonActions = {
  {
    '🔎 files vim config',
    "Files ~/Projects/dotfiles/.vim/after/plugin/",
    {
      ' - Pick a vim config file',
    }
  },
  {
    '🔎 files vim function',
    "Files ~/Projects/dotfiles/.vim/autoload/",
    {
      ' - Pick a file in ~/Projects/dotfiles/.vim/autoload/ folder',
    }
  },
  {
    '🔎 files lua modules',
    "Files ~/Projects/dotfiles/.vim/lua",
    {
      ' - Pick a lua module',
    }
  },
  {
    '🔎 files vim filetype config',
    "Files ~/.vim/ftplugin/",
    {
      ' - Pick a file in ~/.vim/ftplugin/ folder',
    }
  },
  {
    '🔎 files user bin',
    "Files ~/bin",
    {
      ' - Pick a file in ~/bin folder',
    }
  },
  {
    '🔎 grep projects',
    'call common#selectProject("~/Projects", function("common#grepInProjectHandler"), 0)',
    {
      ' - Search in one of project in ~/Projects folder',
    }
  },
  {
    '🔎 zsh config',
    'tabnew ~/.zshrc',
  },
  {
    '🔎 tmux config',
    'tabnew ~/.tmux.conf',
  },
  {
    '🔎 user config',
    "Files ~/.config",
    {
      ' - Pick a file in ~/.config folder',
    }
  },
  {'📌 ctags ruby with lib', 'Dispatch! ctags -R --languages=Ruby --exclude=.git --exclude=log . $(bundle list --paths)'},
  {'📌 ctags ruby', 'Dispatch! ctags -R --languages=Ruby --exclude=.git --exclude=log .'},
  {'📌 ctags js with lib', 'Dispatch! ctags -R --languages=JavaScript --exclude=.git --exclude=dist --exclude=log .'},
  {'📌 ctags js', 'Dispatch! ctags -R --languages=JavaScript --exclude=.git --exclude=log --exclude=node_modules --exclude=dist .'},
  {'📌 ctags python with lib', 'Dispatch! ctags -R --languages=Python --exclude=.git --exclude=log . $(pip show pip | grep Location | cut -d ":" -f 2)'},
  {'📌 ctags python', 'Dispatch! ctags -R --languages=Python --exclude=.git --exclude=log .'},
  {'📌 ctags php', 'Dispatch! ctags -R --languages=PHP --exclude=.git --exclude=log .'},
  {'📌 ctags java with lib', 'Dispatch! ctags -R --languages=java,kotlin --exclude=.git --exclude=log --exclude=.gradle --exclude=.gradle-home --exclude=data . ~/Projects/lib/java'},
  {'📌 ctags java', 'Dispatch! ctags -R --languages=java,kotlin --exclude=.git --exclude=log --exclude=.gradle --exclude=.gradle-home --exclude=data .'},
  {'📌 ctags c', 'Dispatch! ctags -R --languages=c,c++ --exclude=.git .'},
}
```

#### Commands

```viml
" Take actions from g:commonActions variable
nnoremap <space><space> :CommonActions<cr>

" Take actions from g:databases
nnoremap <space>se :DatabaseActions<cr>

" Take actions base on file type, g:kotlinActions for kotlin filetype, g:phpActions for php filetype, g:XXXActions for XXX filetype
nnoremap <space>k :FileTypeActions<cr>
```

## Contributing

All contributions are welcome! Just open a pull request.
<!-- TODO: add plugin documentation -->
When approved,
  changes in the user interface and new built-in functions
  will need to be reflected in the documentation and in `README.md`.
