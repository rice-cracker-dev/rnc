{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.core.hardware.graphics;
in {
  options.core.hardware.graphics = {
    enable = mkEnableOption "graphics";
  };

  config.hardware.graphics = mkIf cfg.enable {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      egl-wayland
    ];
    extraPackages32 = with pkgs; [
      egl-wayland
    ];
  };
}
