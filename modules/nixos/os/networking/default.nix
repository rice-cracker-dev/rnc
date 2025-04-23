{
  imports = [./firewall.nix];

  networking.enableIPv6 = false;
  networking.networkmanager.enable = true;
}
