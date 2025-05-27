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

  background: BorderImage {
    source: Qt.resolvedUrl("root:/assets/tiles/button.png")
    borderSource: Qt.resolvedUrl("root:/assets/tiles/button_border.png")
    color: main.backgroundColor
    borderColor: main.borderColor
    borderSize: 6
  }
}
