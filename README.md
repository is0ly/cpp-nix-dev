# cpp-nix-dev

```sh
nix flake init -t 'github:is0ly/cpp-nix-dev#default'
nix develop
bb build
bb run
bb clean
bb format
bb lint
clang++ -v -E -x c++ /dev/null 
```


## lazyvim

> При использовании редактора neovim с темплейтом lazyvim, необходимо указать редактору путь до clangd (autocmds.lua)
>

```lua
local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  cmd = { "/nix/store/x96xc56a5421nig5wj7fz2kl0syic28b-clang-tools-19.1.7/bin/clangd" },
})
```
