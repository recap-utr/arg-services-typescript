{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{
      flake-parts,
      systems,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      perSystem =
        { pkgs, ... }:
        {
          packages = {
            release-env = pkgs.buildEnv {
              name = "release-env";
              paths = with pkgs; [
                nodejs
                buf
              ];
            };
          };
          devShells.default = pkgs.mkShell {
            shellHook = "npm install";
            packages = with pkgs; [
              nodejs
              buf
            ];
          };
        };
    };
}
