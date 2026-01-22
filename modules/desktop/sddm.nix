{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;

  theme = pkgs.catppuccin-sddm.override {
    flavor = "macchiato";
    accent = "mauve";
  };
in {
  config = mkIf desktop.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "${theme}/share/sddm/themes/catppuccin-macchiato-mauve";
      wayland.enable = true;

      extraPackages = with pkgs; [
        qt6.qtsvg
        qt6.qtdeclarative
      ];
    };
  };
}
