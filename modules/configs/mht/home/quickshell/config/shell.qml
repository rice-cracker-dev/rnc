import Quickshell
import QtQuick
import "./windows"

ShellRoot {
  Variants {
    model: Quickshell.screens

    Scope {
      id: scopeRoot
      property var modelData

      MainBar {
        screen: scopeRoot.modelData
      }
    }
  }
}
