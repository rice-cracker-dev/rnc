{
  inputs,
  pkgs,
  ...
}: let
  neovimPkg = inputs.nvf-config.packages.${pkgs.system}.default;
in {
  #home.packages = [neovimPkg];
  #home.sessionVariables.EDITOR = "${neovimPkg}/bin/nvim";
}
