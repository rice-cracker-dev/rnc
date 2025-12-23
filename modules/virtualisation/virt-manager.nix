{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.enableDesktopModules {
    virtualisation = {
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };
    };

    programs.virt-manager.enable = true;
  };
}
