pragma Singleton
import Quickshell
import QtQuick

Singleton {
  readonly property color background: "#24273a"
  readonly property color foreground: "#cad3f5"
  readonly property color primary: "#c6a0f6"
  readonly property color primaryForeground: "#24273a"
  readonly property color neutral: "#5b6078"
  readonly property color neutralForeground: "#cad3f5"

  function opacity(c: color, o: real): color {
    return Qt.rgba(c.r, c.g, c.b, o);
  }
}
