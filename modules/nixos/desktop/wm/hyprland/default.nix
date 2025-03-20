{inputs, pkgs, ...}: let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.system};
  hyprlandNixpkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system};
in {
  programs.hyprland = {
    enable = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  hardware.graphics = {
    enable32Bit = true;
    package = hyprlandNixpkgs.mesa.drivers;
    package32 = hyprlandNixpkgs.pkgsi686Linux.mesa.drivers;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

