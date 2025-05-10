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
> ```sh
> which clangd
> ```
> И вручную прописать путь. Так же это можно сделать сгенерировав из флейка симлинк и указать его в конфиге

```lua
local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  cmd = { "./.nix-tools/clangd" },
})
```
