import QtQuick
import QtQuick.Layouts
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

      ColumnLayout {
        anchors.fill: parent

        Button {
          id: menuButton
          Layout.fillWidth: true
          Layout.preferredHeight: width

          Icon {
            anchors.centerIn: parent
            icon: Qt.resolvedUrl("root:/assets/nixos-symbolic.svg")
            colorEnabled: true
            color: Theme.on_background
            size: 28
          }

          states: [
            State {
              when: menuButton.pressed
              PropertyChanges {
                target: menuButton
                backgroundColor: Qt.lighter(Theme.surface_variant, 1.5)
                borderColor: Qt.lighter(Theme.outline_variant, 1.5)
              }
            },
            State {
              when: menuButton.hovered
              PropertyChanges {
                target: menuButton
                backgroundColor: Qt.lighter(Theme.surface_variant, 1.25)
                borderColor: Qt.lighter(Theme.outline_variant, 1.25)
              }
            }
          ]
        }

        BorderImage {
          Layout.fillWidth: true
          Layout.fillHeight: true

          source: Qt.resolvedUrl("../../assets/tiles/frame.png")
          borderSource: Qt.resolvedUrl("../../assets/tiles/frame_border.png")
          color: Theme.background
          borderColor: Theme.outline_variant
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
}
