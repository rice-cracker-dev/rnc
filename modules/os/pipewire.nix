{pkgs, ...}: {
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # https://gitlab.com/fazzi/nixohess/-/blob/main/modules/core/pipewire/default.nix
    extraConfig.pipewire-pulse."92-rtkit" = {
      context.modules = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            # make audio extremely high priority to avoid crackling
            "nice.level" = -20;
            "rt.prio" = 99;
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [pulseaudio pavucontrol]; # pactl
}
