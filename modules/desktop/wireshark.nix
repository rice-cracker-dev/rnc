{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchFromGitLab;
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    programs.wireshark.enable = true;
    home.packages = with pkgs; [wireshark];

    core.user.extraGroups = ["wireshark"];

    # TODO: remove this after https://nixpk.gs/pr-tracker.html?pr=515269 reaches nixos-unstable
    nixpkgs.overlays = [
      (_: prev: {
        wireshark = prev.wireshark.overrideAttrs (final: {
          src = fetchFromGitLab {
            repo = "wireshark";
            owner = "wireshark";
            tag = "v${final.version}";
            hash = "sha256-Zvrwxjp4LK2J3QnxmPxKKrU01YHQvPyp54UWzeGNCjA=";
          };
        });
      })
    ];
  };
}
