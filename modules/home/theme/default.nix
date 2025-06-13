{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = [
    ./cursor.nix
    ./gtk.nix
    ./iconTheme.nix
    ./kvantum.nix
    ./qtct.nix
  ];

  options.home.theme.enable = mkEnableOption "enable theme home configuration";
}
