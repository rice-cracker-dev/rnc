{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./cursor.nix
    ./gtk.nix
    ./iconTheme.nix
    ./kvantum.nix
  ];

  options.home.theme.enable = mkEnableOption "enable theme home configuration";
}
