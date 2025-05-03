{
  pkgs,
  inputs,
  ...
}: {
  config.me.packages = [inputs.nvf-config.packages.${pkgs.system}.default];
}
