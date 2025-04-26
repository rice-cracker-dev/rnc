{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  hardware.graphics = {
    enable32Bit = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

