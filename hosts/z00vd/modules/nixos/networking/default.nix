{
  imports = [./firewall.nix];

  networking.hostName = "z00vd";
  networking.networkmanager.enable = true;
}
