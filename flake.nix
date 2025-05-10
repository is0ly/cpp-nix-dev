{
  description = "A Nix-flake-based C/C++ development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f {
          pkgs = import nixpkgs { inherit system; };
          inherit system;
        });
    in {
      devShells = forEachSupportedSystem ({ pkgs, system }: {
        default = pkgs.mkShell.override {
          stdenv = pkgs.clangStdenv;
        } {
          packages = with pkgs;
            [
              babashka
              lua
              clang-tools
              cmake
              codespell
              conan
              cppcheck
              doxygen
              gtest
              lcov
              vcpkg
              vcpkg-tool
            ] ++ (if system == "aarch64-darwin" then [ ] else [ gdb ]);

          shellHook = ''
            echo "🔧 Entering C/C++ dev shell (clang)..."
            mkdir -p .nix-tools
            ln -sf $(which clangd) .nix-tools/clangd
            exec zsh
          '';
        };
      });

      templates.default = {
        path = self;
        description = "C/C++ dev environment with Clang and tools";
      };
    };
}
