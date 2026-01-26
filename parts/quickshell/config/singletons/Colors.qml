pragma Singleton
import Quickshell
import QtQuick

Singleton {
  property color background: "#24273a"
  property color foreground: "#cad3f5"
  property color primary: "#c6a0f6"
  property color primaryForeground: "#24273a"
  property color neutral: "#363a4f"
  property color neutralForeground: "#cad3f5"

  function opacity(c: color, o: real): color {
    return Qt.rgba(c.r, c.g, c.b, o);
  }
}
