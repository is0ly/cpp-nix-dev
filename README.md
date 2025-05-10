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
