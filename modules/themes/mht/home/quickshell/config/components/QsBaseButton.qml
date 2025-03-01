import QtQuick 6.8
import QtQuick.Controls 6.8
import ".."
import "../utils"

Button {
  property color backgroundColor: Style.base200
  property color activeColor: Qt.lighter(Style.base200, 1.4)
  property int borderRadius: Style.contentRadius
  property bool ghosted: false
  property bool active: false

  id: control

  hoverEnabled: true

  background: Rectangle {
    id: backgroundRect

    color: control.ghosted ? "transparent" : control.backgroundColor 
    radius: control.borderRadius
  }

  states: [
    State {
      name: "active"; when: control.active;
      PropertyChanges { target: backgroundRect; color: control.activeColor }
    },

    State {
      name: "hovered"; when: control.hovered;
      PropertyChanges {
        target: backgroundRect;
        color: ghosted
          ? Color.opacify(control.backgroundColor, 0.75)
          : Qt.lighter(control.backgroundColor, 1.2)
      }
    }
  ]

  transitions: Transition {
    ColorAnimation { target: backgroundRect; properties: "color"; easing.type: Easing.InOutQuad }
  }
}
