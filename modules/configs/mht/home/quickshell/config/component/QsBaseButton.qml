import Quickshell
import QtQuick
import QtQuick.Controls
import "../config"

Button {
  id: root
  property string variant: 'surface_variant'
  property string backgroundColor: Colorscheme.getColor(variant) ?? 'transparent'
  property string textColor: Colorscheme.getColor(`on_${variant}`) ?? '#000000'
  property int radius: 4
  property bool active: false

  hoverEnabled: true

  icon.color: textColor

  background: Rectangle {
    id: backgroundRect

    color: root.backgroundColor
    radius: root.radius

    Behavior on color {
      ColorAnimation {
        duration: 150
      }
    }
  }

  states: [
    State {
      when: root.pressed || root.active
      PropertyChanges {
        backgroundRect.color: Qt.lighter(root.backgroundColor, 2)
      }
    },
    State {
      when: root.hovered
      PropertyChanges {
        backgroundRect.color: Qt.lighter(root.backgroundColor, 1.5)
      }
    }
  ]
}
