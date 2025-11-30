{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf-config.url = "github:rice-cracker-dev/nvf-config";
    swww.url = "github:LGFae/swww";
    nh.url = "github:nix-community/nh";
    glfw3-minecraft-fix.url = "github:Piecuuu/nixpkgs/glfw-minecraft-fix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    blender-bin.url = "github:edolstra/nix-warez?dir=blender";

    nvidia-patch = {
      url = "github:icewind1991/nvidia-patch-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty-shaders = {
      url = "github:hackr-sh/ghostty-shaders";
      flake = false;
    };

    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    catppuccin-kitty = {
      url = "github:catppuccin/kitty";
      flake = false;
    };

    hjem = {
      url = "github:feel-co/hjem/31f969f69f02b62e417bcc39571a605977cb89fa";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:rice-cracker-dev/hjem-rum/dirty-patch";
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
