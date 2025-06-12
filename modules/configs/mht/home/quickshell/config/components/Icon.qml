import QtQuick
import QtQuick.Effects
import Quickshell.Widgets

Item {
  id: main
  required property url icon
  required property int size
  property bool colorEnabled: true
  property color color: "#000000"

  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height

  IconImage {
    id: icon
    source: main.icon
    visible: !main.colorEnabled
    implicitSize: main.size
  }

  MultiEffect {
    source: icon
    anchors.fill: icon
    colorization: 1
    colorizationColor: main.color
    visible: main.colorEnabled
  }
}
