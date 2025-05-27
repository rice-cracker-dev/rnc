import QtQuick
import Quickshell
import "root:"
import "root:/components"

Variants {
  model: Quickshell.screens

  Scope {
    id: scopeRoot
    property var modelData

    PanelWindow {
      screen: scopeRoot.modelData

      anchors {
        top: true
        bottom: true
        left: true
      }

      margins {
        top: 8
        bottom: 8
        left: 8
      }

      color: "transparent"
      implicitWidth: 48

      BorderImage {
        anchors.fill: parent

        source: Qt.resolvedUrl("../../assets/tiles/frame_x2.png")
        borderSize: 6

        Column {
          anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 16
          }

          spacing: 16

          ClockWidget {}
        }
      }
    }
  }
}
