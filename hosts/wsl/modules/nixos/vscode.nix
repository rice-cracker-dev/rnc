{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    vscode.fhs
  ];

  programs.nix-ld.enable = true;
}
