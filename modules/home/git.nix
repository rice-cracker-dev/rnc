{pkgs, ...}: {
  config.me = {
    packages = with pkgs; [gh lazygit];

    rum.programs.git = {
      enable = true;

      settings = {
        user = {
          name = "rice-cracker-dev";
          email = "ricecracker2234@proton.me";
        };
      };
    };
  };
}
