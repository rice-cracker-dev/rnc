pragma Singleton

import QtQuick 6.8
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
  property var clients: []

  Component.onCompleted: () => {
    console.log("hello world")
  }
}
