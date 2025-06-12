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
                menuButton.backgroundColor: Qt.lighter(Theme.surface_variant, 1.5)
                menuButton.borderColor: Qt.lighter(Theme.outline_variant, 1.5)
              }
            },
            State {
              when: menuButton.hovered
              PropertyChanges {
                menuButton.backgroundColor: Qt.lighter(Theme.surface_variant, 1.25)
                menuButton.borderColor: Qt.lighter(Theme.outline_variant, 1.25)
              }
            }
          ]
        }

        Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true

          color: Theme.background
          border {
            color: Theme.outline_variant
            width: 1
          }

          radius: 4

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
