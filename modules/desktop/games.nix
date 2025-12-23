{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    programs = {
      steam = {
        enable = false;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      gamescope = {
        enable = true;
        capSysNice = true;
        args = ["--mangoapp" "--expose-wayland"];
        env = {
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };
      };

      gamemode.enable = true;
    };

    me.files = {
      ".local/share/Steam/steam_dev.cfg".text = ''
        unShaderBackgroundProcessingThreads 4
      '';

      ".config/MangoHud/MangoHud.conf".text = ''
        gpu_name
        gpu_temp
        gpu_power

        cpu_temp

        ram

        fps
        frametime

        gamemode
      '';
    };

    environment.systemPackages = with pkgs; [
      mangohud

      (prismlauncher.override {
        jdks = [
          zulu8
          zulu17
          zulu21
        ];
      })

      # (heroic.override {
      #   extraPkgs = pkgs: [
      #     pkgs.gamescope
      #     pkgs.gamemode
      #     pkgs.mangohud
      #   ];
      # })
    ];
  };
}
