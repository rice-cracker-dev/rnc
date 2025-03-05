{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # hyprland my love
    hyprland.url = "github:hyprwm/Hyprland";

    # my neovim-flake config
    nvf-config.url = "github:rice-cracker-dev/nvf-config";

    # ags
    ags.url = "github:aylur/ags"; 

    # quickshell
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
