{lib, ...}: let
  inherit (lib) mkForce;
in {
  config = {
    core.hardware = {
      graphics.enable = true;

      nvidia = {
        enable = true;

        offload = {
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
      };
    };

    specialisation.disable-nvidia.configuration = {
      core.hardware.nvidia.enable = mkForce false;
    };
  };
}
