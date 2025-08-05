{inputs, ...}: {
  imports = [inputs.ngrok.nixosModules.ngrok];

  services.ngrok = {
    enable = true;
  };
}
