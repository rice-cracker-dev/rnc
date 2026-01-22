{pkgs, ...}: {
  config = {
    users.defaultUserShell = pkgs.bash;

    programs.bash = {
      enable = true;

      interactiveShellInit = ''
        exec ${pkgs.nushell}/bin/nu
      '';
    };

    home.rum.programs = {
      nushell = {
        enable = true;

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

      starship = {
        enable = true;
        integrations.nushell.enable = true;

        settings = {
          add_newline = false;
          format = "$username@$hostname $directory$git_branch$status> ";
          right_format = "$cmd_duration";

          cmd_duration = {
            format = "[took $duration]($style)";
            style = "bold green";
            min_time = 500;
          };

          username = {
            format = "[$user]($style_user)";
            style_user = "green";
            show_always = true;
          };

          hostname = {
            format = "[$hostname]($style)";
            style = "white";
            ssh_only = false;
          };

          directory = {
            format = "[$path]($style)[$read_only]($read_only_style)";
            style = "white";
            fish_style_pwd_dir_length = 1;
            truncation_length = 1;
          };

          git_branch = {
            format = " [\\($branch\\)]($style)";
            style = "white";
          };

          status = {
            disabled = false;
            format = " [\\[$status\\]]($style)";
          };
        };
      };
    };
  };
}
