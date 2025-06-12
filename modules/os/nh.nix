{
  inputs,
  pkgs,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${pkgs.system}.default;
    flake = "/home/${username}/nixos";
    clean.enable = true;
  };
}
