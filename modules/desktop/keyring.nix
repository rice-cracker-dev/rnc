{pkgs, ...}: {
  environment.systemPackages = [pkgs.libsecret];

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  systemd.user.services.gnome-keyring = {
    description = "gnome-keyring";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon -f";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
