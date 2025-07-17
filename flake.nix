{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf-config.url = "github:rice-cracker-dev/nvf-config";
    rix-shell.url = "github:rice-cracker-dev/rix-shell";
    swww.url = "github:LGFae/swww";
    nh.url = "github:nix-community/nh";
    glfw3-minecraft-fix.url = "github:Piecuuu/nixpkgs/glfw-minecraft-fix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

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

      rc555 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username riceLib;};
        modules = [
          ./hosts/rc555/configuration.nix
        ];
      };
    };
  };
}
