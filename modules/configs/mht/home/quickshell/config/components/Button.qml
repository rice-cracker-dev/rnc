import QtQuick
import QtQuick.Controls
import ".."

Button {
  id: main
  property color backgroundColor: Theme.surface_variant
  property color color: Theme.on_surface_variant

  hoverEnabled: true

  background: Rectangle {
    color: main.backgroundColor
    radius: 8

    Behavior on color {
      ColorAnimation {
        duration: 150
      }
    }
  }
}
