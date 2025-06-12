import QtQuick
import QtQuick.Controls
import "."
import ".."

Button {
  id: main
  property color backgroundColor: Theme.surface_variant
  property color borderColor: Theme.outline_variant
  property color color: Theme.on_surface_variant

  hoverEnabled: true

  background: Rectangle {
    color: main.backgroundColor
    border {
      color: main.borderColor
      width: 1
    }
  }
}
