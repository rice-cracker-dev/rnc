{
  inputs,
  pkgs,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.default;
    flake = "/home/${username}/nixos";
    clean.enable = true;
  };
}
