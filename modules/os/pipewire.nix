{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    environment.systemPackages = with pkgs; [qpwgraph pwvucontrol];
  };
}
