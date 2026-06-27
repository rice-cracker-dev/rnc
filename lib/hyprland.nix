{
  dispatcher = {
    exec_cmd = action: "hl.dsp.exec_cmd(${action})";
    focus = opt: "hl.dsp.focus(${opt})";

    window = {
      move = opt: "hl.dsp.window.move(${opt})";
    };
  };

  mkHyprlandBind = key: action: flag: {inherit key action flag;};
}
