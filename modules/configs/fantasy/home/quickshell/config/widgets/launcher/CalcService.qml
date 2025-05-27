pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: main

  property string result
  property int code: -1

  Process {
    id: proc

    running: false

    stdout: SplitParser {
      onRead: data => {
        console.log(data)
        main.result = data;
      }
    }

    onExited: exitCode => {
      main.code = exitCode
    }
  }

  function calculateExpression(expr) {
    proc.signal(9)
    proc.command = ["qalc", "-t", expr];
    proc.running = true;
  }
}
