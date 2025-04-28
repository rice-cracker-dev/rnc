{
  inputs,
  pkgs,
  ...
}: {
  config.me.packages = [inputs.nvf-config.packages.${pkgs.system}.default];
}
