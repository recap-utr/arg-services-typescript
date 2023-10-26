{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    npmlock2nix = {
      url = "github:nix-community/npmlock2nix";
      flake = false;
    };
  };
  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    systems,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      perSystem = {
        pkgs,
        lib,
        ...
      }: let
        npmlock2nix = import inputs.npmlock2nix {inherit pkgs;};
      in {
        packages = {
          releaseEnv = pkgs.buildEnv {
            name = "release-env";
            paths = with pkgs; [nodejs];
          };
          bufGenerate = pkgs.writeShellApplication {
            name = "buf-generate";
            text = ''
              export PATH="${lib.getBin npmlock2nix.v2.node_modules {
                src = ./.;
                nodejs = pkgs.nodejs;
              }}/bin:$PATH"
              ${lib.getExe pkgs.buf} mod update
              ${lib.getExe pkgs.buf} generate --include-imports buf.build/recap/arg-services
            '';
          };
        };
        devShells.default = pkgs.mkShell {
          shellHook = "npm install";
          packages = with pkgs; [nodejs];
        };
      };
    };
}
