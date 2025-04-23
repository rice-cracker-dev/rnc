{pkgs, ...}: {
  programs.fish.plugins = [
    {
      name = "fzf-fish";
      inherit (pkgs.fishPlugins.fzf-fish) src;
    }
  ];
}
