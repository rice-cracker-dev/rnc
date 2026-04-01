{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) nullOr enum;

  cfg = config.core.hardware.graphics;
in {
  options.core.hardware.graphics = {
    enable = mkEnableOption "graphics";

    videoAcceleration = mkOption {
      type = nullOr (enum ["nvidia" "intel"]);
      default = null;
    };
  };

  config.hardware = mkIf cfg.enable {
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        egl-wayland
        libva-vdpau-driver
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        egl-wayland
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };
}
