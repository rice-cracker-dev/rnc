import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:"

Variants {
  model: Quickshell.screens

  Scope {
    id: scopeRoot
    property var modelData

    PanelWindow {
      screen: scopeRoot.modelData

      WlrLayershell.layer: WlrLayer.Background

      anchors {
        top: true
        left: true
        right: true
        bottom: true
      }

      Image {
        sourceSize {
          width: parent.width
          height: parent.height
        }

        source: Qt.resolvedUrl("../assets/background.png")
      }
    }
  }
}
