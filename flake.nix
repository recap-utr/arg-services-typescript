{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      systems,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      perSystem =
        { pkgs, lib, ... }:
        {
          packages = {
            releaseEnv = pkgs.buildEnv {
              name = "release-env";
              paths = with pkgs; [ nodejs ];
            };
            bufGenerate = pkgs.writeShellApplication {
              name = "buf-generate";
              text = ''
                ${lib.getExe pkgs.buf} mod update
                ${lib.getExe pkgs.buf} generate --include-imports buf.build/recap/arg-services
              '';
            };
          };
          devShells.default = pkgs.mkShell {
            shellHook = "npm install";
            packages = with pkgs; [ nodejs ];
          };
        };
    };
}
