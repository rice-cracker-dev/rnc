{pkgs, ...}: {
  config.me = {
    packages = with pkgs; [
      bat
      fd
      ripgrep
      eza
      diskus
      libqalculate
      jq
    ];

    rum.programs = {
      fzf.enable = true;

      nushell = {
        enable = true;

        aliases = {
          cat = "${pkgs.bat}/bin/bat";
          ls = "${pkgs.eza}/bin/eza";
        };

        settings = {
          show_banner = false;
        };
      };

      zoxide = {
        enable = true;
        flags = ["--cmd cd"];
        integrations.nushell.enable = true;
      };

      direnv = {
        enable = true;

        settings = {
          global.warn_timeout = "0s";
        };

        integrations = {
          nushell.enable = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
