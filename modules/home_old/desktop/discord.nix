{pkgs, ...}: {
  config = {
    home.packages = [
      (pkgs.discord.override {
        withVencord = true;
      })
    ];
  };
}
