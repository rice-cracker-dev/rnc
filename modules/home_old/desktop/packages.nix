{pkgs, ...}: {
  config.home.packages = with pkgs; [
    ark
    blender
    mpv
    transmission
  ];
}
