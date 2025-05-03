{pkgs, ...}: {
  programs = {
    command-not-found.enable = false;

    bash = {
      enable = true;

      shellAliases = {
        cat = "${pkgs.bat}/bin/bat";
      };

      interactiveShellInit = ''
        if uwsm check may-start && uwsm select; then
          exec uwsm start default
        fi

        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != " fish " && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=" "
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    fish = {
      enable = true;

      shellInit = ''
        set fish_greeting
      '';
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
    };
  };
}
