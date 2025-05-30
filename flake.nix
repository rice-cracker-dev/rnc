{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf-config.url = "github:rice-cracker-dev/nvf-config";
    mht-shell.url = "github:rice-cracker-dev/mht-shell";
    swww.url = "github:LGFae/swww";

    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    catppuccin-kitty = {
      url = "github:catppuccin/kitty";
      flake = false;
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    username = "khoa";
    riceLib = import ./lib nixpkgs.lib;
  in {
    lib = nixpkgs.lib // riceLib;

    nixosConfigurations = {
      z00vd = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username riceLib;};
        modules = [
          ./hosts/z00vd/configuration.nix
        ];
      };
    };
  };
}
