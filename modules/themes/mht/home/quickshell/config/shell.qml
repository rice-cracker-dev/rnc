import QtQuick 6.8
import QtQuick.Layouts 6.8
import Quickshell
import "./components"
import "./widgets"

ShellRoot {
  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        property var modelData

        id: window

        screen: modelData

        anchors {
          top: true
          left: true
          right: true
        }

        height: 32

        color: "transparent"

        QsCard {
          id: main

          anchors.fill: parent
          borderRadius: 0

          leftPadding: 8
          rightPadding: 8

          RowLayout {
            anchors.fill: parent
            uniformCellSizes: true
            spacing: 8

            RowLayout {
              Layout.alignment: Qt.AlignLeft 
              spacing: 8

              HyprlandWidget {}
            }

            RowLayout {
              Layout.alignment: Qt.AlignCenter
              spacing: 8

              MprisWidget { window: window }
            }

            RowLayout {
              Layout.alignment: Qt.AlignRight 
              spacing: 8

              SystemTrayWidget {}
              ClockWidget {}
            }
          }
        }
      }
    }
  }
}
