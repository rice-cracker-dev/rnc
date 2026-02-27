{
  config,
  lib,
  pkgs,
  inputs,
  inputs',
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;

  catppuccin-kde-macchiato = pkgs.catppuccin-kde.override {
    flavour = ["macchiato"];
    accents = ["mauve"];
  };
in {
  imports = [inputs.qtengine.nixosModules.default];

  config = mkIf desktop.enable {
    environment.systemPackages = with pkgs; [
      papirus-icon-theme
      inputs'.nixpkgs-stable.legacyPackages.darkly
      inputs'.nixpkgs-stable.legacyPackages.darkly-qt5
    ];

    programs.qtengine = {
      enable = true;

      config = {
        theme = {
          colorScheme = "${catppuccin-kde-macchiato}/share/color-schemes/CatppuccinMacchiatoMauve.colors";
          iconTheme = "Papirus-Dark";
          style = "Darkly";

          font = {
            family = "Noto Sans";
            size = 11;
            weight = -1;
          };

          fontFixed = {
            family = "JetBrainsMono Nerd Font";
            size = 11;
            weight = -1;
          };
        };

        misc = {
          singleClickActivate = false;
          menusHaveIcons = true;
          shortcutsForContextMenus = true;
        };
      };
    };
  };
}
