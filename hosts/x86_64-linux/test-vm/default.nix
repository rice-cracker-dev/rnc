{config, ...}: let
  inherit (config.core.user) username;
in {
  users.users.${username}.initialPassword = "123";

  desktop.uwsm = {
    defaultEnv = {
      TEST = "one two three";
    };

    desktopEnv.hyprland = {
      AQ_YOUR_MOM = "hi";
    };
  };

  system.stateVersion = "24.11";
}
