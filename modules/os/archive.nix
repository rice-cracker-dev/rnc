{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zip
    unzip
    unrar
    p7zip
  ];
}
