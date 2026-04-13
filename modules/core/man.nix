{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [man-pages man-pages-posix];
    documentation = {
      dev.enable = true;
      man = {
        enable = true;
        man-db.enable = true;
        mandoc.enable = false;
      };
    };
  };
}
