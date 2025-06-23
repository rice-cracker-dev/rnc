{
  inputs,
  pkgs,
  ...
}: {
  config.me.packages = [inputs.rix-shell.packages.${pkgs.system}.default];
}
