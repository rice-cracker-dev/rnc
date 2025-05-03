import Quickshell
import QtQuick
import "./window"

ShellRoot {
  Variants {
    model: Quickshell.screens

    Scope {
      id: scopeRoot
      property var modelData

      MainBar {
        screen: scopeRoot.modelData
      }
      ActivateLinux {
        screen: scopeRoot.modelData
      }
    }
  }
}
