{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) desktop;
in {
  config = mkIf desktop.enable {
    virtualisation = {
      spiceUSBRedirection.enable = false;

      libvirtd = {
        enable = false;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };
    };

    programs.virt-manager.enable = false;
  };
}
