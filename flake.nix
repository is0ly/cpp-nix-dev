{
  description = "A Nix-flake-based C/C++ development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/23.11"; # Лучше стабильную ревизию
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell.override {
          stdenv = pkgs.clangStdenv;
        } {
          packages = with pkgs; [
            babashka
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
            zsh
          '';
        };
      }
    ) // {
      templates.default = {
        path = ./.;
        description = "C/C++ dev environment with Clang and tools";
      };
    };
}
