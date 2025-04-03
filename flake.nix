{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # my neovim-flake config
    nvf-config.url = "github:rice-cracker-dev/nvf-config";

    # shells
    mht-shell.url = "github:rice-cracker-dev/mht-shell";

    # swww
    swww.url = "github:LGFae/swww";

    # catppuccin-btop
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    username = "khoa";
  in {
    nixosConfigurations = {
      z00vd = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username;};
        modules = [
          ./hosts/z00vd/configuration.nix
        ];
      };
    };
  };
}
