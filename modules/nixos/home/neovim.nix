{
  inputs,
  pkgs,
  ...
}: {
  config.home.packages = [inputs.nvf-config.packages.${pkgs.system}.default];
}
