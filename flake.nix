{
  description = "nat's packages, modules and overrides ^_^";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
        config.allowUnfree = true;
      };
    in
    {
      overlays.default = (final: prev: rec {
        modules = {
          anime4k = import ./modules/anime4k;
        };
        anime4k = final.callPackage ./pkgs/anime4k { };
        apple-emoji-linux = final.callPackage ./pkgs/apple-emoji-linux { };
        feather-wallet = final.callPackage ./pkgs/feather-wallet { };
      });
      legacyPackages.x86_64-linux = pkgs;
    };
}
