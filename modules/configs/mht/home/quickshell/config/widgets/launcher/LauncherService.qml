pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: main
  property bool open: false

  IpcHandler {
    target: "launcher"

    function toggle() {
      main.open = !main.open;
      console.log(main.open);
    }
  }

  Process {
    id: proc
  }

  function runCommand(command) {
    proc.command = command;
    proc.startDetached();
  }
}
