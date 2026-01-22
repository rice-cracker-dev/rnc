{
  config.home.rum.programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        ratio = [0 7 3];
        show_hidden = true;
        image_delay = 500; # wait at least 200ms before loading images
      };

      opener = {
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];

        edit = [
          {
            run = "$EDITOR \"$@\"";
            block = true;
            for = "unix";
          }
        ];

        open = [
          {run = "xdg-open \"$@\"";}
        ];
      };

      open.prepend_rules = [
        {
          mime = "text/*";
          use = "edit";
        }
        {
          mine = "video/*";
          use = "play";
        }
      ];
    };
  };
}
