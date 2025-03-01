import QtQuick 6.8
import QtQuick.Controls 6.8
import QtQuick.Layouts 6.8
import Quickshell.Hyprland
import ".."

RowLayout {
  Repeater {
    model: Array.from({ length: 9 }).map((_, i) => i + 1)

    Button {
      required property int modelData

      property bool isSelected: Hyprland.focusedMonitor?.activeWorkspace?.id === workspaceButton.modelData

      id: workspaceButton

      hoverEnabled: true
      onClicked: () => Hyprland.dispatch(`workspace ${modelData}`)

      implicitWidth: 8
      implicitHeight: 8

      background: Rectangle {
        id: backgroundRect
        
        color: Style.base200
        radius: 9999
      }

      states: [
        State {
          name: "active"; when: workspaceButton.isSelected
          PropertyChanges { target: backgroundRect; color: Style.accent }
          PropertyChanges { target: workspaceButton; implicitWidth: 16 }
        },

        State {
          name: "hovered"; when: workspaceButton.hovered
          PropertyChanges { target: backgroundRect; color: Qt.lighter(Style.base200, 1.2) }
        }
      ]

      transitions: Transition {
        ColorAnimation { target: backgroundRect; properties: "color"; easing.type: Easing.InOutQuad }
        NumberAnimation { properties: "implicitWidth"; easing.type: Easing.InOutQuad }
      }
    }
  }
}
