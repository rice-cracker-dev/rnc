import QtQuick
import QtQuick.Effects
import Quickshell.Widgets

Item {
  id: main
  required property url icon
  required property int size
  property color color: Qt.color("#000000")

  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height

  IconImage {
    id: icon
    source: main.icon
    visible: false
    implicitSize: main.size
  }

  MultiEffect {
    source: icon
    anchors.fill: icon
    brightness: 1
    colorization: 1
    colorizationColor: main.color
  }
}
