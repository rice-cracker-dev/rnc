{inputs, pkgs, config, lib, ...}: let
  uwsm = import "${inputs.self}/lib/uwsm.nix";
in {
  options.quickshell = {
    enable = lib.mkEnableOption "enable quickshell";

    configDir = lib.mkOption {
      type = lib.types.path;
      description = "path to quickshell config";
    };
  };

  config = let 
    quickshellPkg = inputs.quickshell.packages.${pkgs.system}.default;
  in lib.mkIf config.quickshell.enable {
    home.packages = [quickshellPkg];

    xdg.configFile.quickshell = {
      source = config.quickshell.configDir;
      recursive = true;
    };

    wayland.windowManager.hyprland.settings.exec-once = [
      (uwsm.useUWSM "quickshell")
    ];
  };
}
