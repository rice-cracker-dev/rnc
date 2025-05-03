import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

Item {
  id: root
  required property url source
  required property real size
  property color color: null

  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height

  IconImage {
    id: contentIcon

    source: root.source
    implicitSize: root.size
    visible: false
  }

  MultiEffect {
    source: contentIcon
    anchors.fill: contentIcon
    brightness: 1
    colorization: 1
    colorizationColor: root.color ?? "#ffffff"
  }
}
