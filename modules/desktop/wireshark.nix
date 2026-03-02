{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    programs.wireshark.enable = true;
    home.packages = with pkgs; [wireshark];

    core.user.extraGroups = ["wireshark"];
  };
}
