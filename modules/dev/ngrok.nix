{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ngrok.nixosModules.ngrok];

  environment.systemPackages = [
    pkgs.ngrok
  ];

  services.ngrok = {
    enable = true;
  };
}
