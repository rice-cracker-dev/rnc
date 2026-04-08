{
  config.home.rum.programs.helix.settings = {
    keys.insert = {
      "C-space" = "completion";
    };

    keys.normal = {
      space.y = [
        ":sh rm -f /tmp/unique-file"
        ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/unique-file"
        ":sh printf \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
        ":open %sh{cat /tmp/unique-file}"
        ":redraw"
      ];
    };
  };
}
