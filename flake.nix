{
  description = "rnc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    swww.url = "github:LGFae/swww";
    nh.url = "github:nix-community/nh/47374db9bc89fabec665daf0c0903d400c10ef84"; # the last commit was faulty oops
    glfw3-minecraft-fix.url = "github:Piecuuu/nixpkgs/glfw-minecraft-fix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
    ricevim.url = "github:rice-cracker-dev/ricevim";

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

  outputs = {
    flake-parts,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (let
      inherit (nixpkgs) lib;

      username = "khoa";
      riceLib = import ./lib lib;
    in {
      systems = ["x86_64-linux"];

      flake = {
        lib = lib // riceLib;

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

          wsl = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs username riceLib;};
            modules = [
              ./hosts/wsl/configuration.nix
            ];
          };
        };
      };

      perSystem = {pkgs, ...}: let
        packages = lib.filesystem.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./pkgs;
        };
      in {inherit packages;};
    });
}
